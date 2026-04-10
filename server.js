const express = require("express");
const cors = require ("cors");
const db = require("./db");

const app = express();
app.use(cors());
app.use(express.json());
// test
app.get("/", (req, res) => {
    res.send("Server running 🚀");
});

// blood search API
app.get("/blood/:group", (req, res) => {
    const group = req.params.group;

    const sql = `
    SELECT Hospital.name, BloodInventory.units_available
    FROM BloodInventory
    JOIN Hospital ON BloodInventory.hospital_id = Hospital.hospital_id
    WHERE BloodInventory.blood_group = ?`;

    db.query(sql, [group], (err, result) => {
        if (err) {
            res.send(err);
        } else {
            res.json(result);
        }
    });
});

app.post("/register", (req, res) => {
    const { name, email, password, blood_group } = req.body;

    const sql = "INSERT INTO Users (name, email, password, blood_group, role) VALUES (?, ?, ?, ?, 'user')";

    db.query(sql, [name, email, password, blood_group], (err, result) => {
        if (err) {
            res.send("Error registering user");
        } else {
            res.send("User registered successfully ✅");
        }
    });
});
app.post("/login", (req, res) => {
    const { email, password } = req.body;

    const sql = "SELECT * FROM Users WHERE email = ? AND password = ?";

    db.query(sql, [email, password], (err, result) => {
        if (err) {
            res.send(err);
        } else {
            if (result.length > 0) {
                res.send("Login successful ✅");
            } else {
                res.send("Invalid credentials ❌");
            }
        }
    });
});
app.post("/add-donor", (req, res) => {
    const { user_id, medical_history } = req.body;

    const sql = `
    INSERT INTO Donor (user_id, last_donation_date, medical_history, eligibility_status)
    VALUES (?, CURDATE(), ?, 'Eligible')`;

    db.query(sql, [user_id, medical_history], (err, result) => {
        if (err) {
            res.send("Error adding donor");
        } else {
            res.send("Donor added successfully ✅");
        }
    });
});
app.post("/donate", (req, res) => {
    const { donor_id, hospital_id, blood_group, units } = req.body;

    // Step 1: Add donation history
    const donationSql = `
    INSERT INTO DonationHistory (donor_id, hospital_id, date, units_donated)
    VALUES (?, ?, CURDATE(), ?)`;

    db.query(donationSql, [donor_id, hospital_id, units], (err, result) => {
        if (err) {
            res.send("Error in donation");
        } else {

            // Step 2: Update blood inventory
            const updateSql = `
            UPDATE BloodInventory
            SET units_available = units_available + ?
            WHERE hospital_id = ? AND blood_group = ?`;

            db.query(updateSql, [units, hospital_id, blood_group], (err2, result2) => {
                if (err2) {
                    res.send("Donation saved but inventory not updated");
                } else {
                    res.send("Donation successful & inventory updated ✅");
                }
            });
        }
    });
});
app.get("/reward/:donor_id", (req, res) => {
    const donor_id = req.params.donor_id;

    const sql = `
    SELECT COUNT(*) AS total_donations 
    FROM DonationHistory 
    WHERE donor_id = ?`;

    db.query(sql, [donor_id], (err, result) => {
        if (err) {
            res.send(err);
        } else {
            const count = result[0].total_donations;

            if (count >= 3) {
                res.send(`🎉 You are a Gold Donor! Total Donations: ${count}`);
            } else {
                res.send(`Keep donating! Total Donations: ${count}`);
            }
        }
    });
});
app.get("/hospitals", (req, res) => {
    db.query("SELECT * FROM Hospital", (err, result) => {
        if (err) res.send(err);
        else res.json(result);
    });
});
app.listen(3000, () => {
    console.log("Server running on port 3000");
});