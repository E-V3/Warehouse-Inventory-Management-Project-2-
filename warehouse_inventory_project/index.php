<?php
session_start();
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

include 'functions.php';

// Join
$sql = "SELECT p.id, p.name, p.description, p.quantity, p.price, s.name AS supplier_name 
        FROM products p
        LEFT JOIN suppliers s ON p.supplier_id = s.id";
$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Warehouse Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Welcome, <?php echo $_SESSION['username']; ?>!</h2>
    <p>This is your warehouse dashboard.</p>

    <h3>Current Inventory</h3>
    <table border="1">
        <tr>
            <th>Product Name</th>
            <th>Description</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Supplier</th>
        </tr>
        <?php
        if ($result->num_rows > 0) {
            while ($row = $result->fetch_assoc()) {
                echo "<tr>
                        <td>{$row['name']}</td>
                        <td>{$row['description']}</td>
                        <td>{$row['quantity']}</td>
                        <td>\${$row['price']}</td>
                        <td>{$row['supplier_name']}</td>
                    </tr>";
            }
        } else {
            echo "<tr><td colspan='5'>No inventory available.</td></tr>";
        }
        ?>
    </table>

    <a href="logout.php">Logout</a>
</body>
</html>