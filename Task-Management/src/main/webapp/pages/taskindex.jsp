<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Management</title>
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>  
<style>
/* General body styling */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    background-color: #e6f7ff; /* Light blue background */
    margin: 0;
    padding: 0;
}

/* Container styling */
.container {
    width: 90%;
    max-width: 1200px;
    margin: 40px auto;
    background: #ffffff;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
}

/* Header styles */
h1 {
    font-size: 2.5rem;
    text-align: center;
    color: #333;
    margin-bottom: 40px;
    font-weight: 600;
}

h2 {
    font-size: 1.75rem;
    text-align: center;
    color: #555;
    margin-bottom: 20px;
}

/* Form Styles */
form {
    margin-bottom: 30px;
    display: flex;
    flex-direction: column;
    gap: 20px;
}

label {
    font-size: 1.1rem;
    font-weight: bold;
    color: #333;
}

input, textarea, select {
    padding: 12px;
    border: 1px solid #ddd;
    border-radius: 8px;
    font-size: 1rem;
    width: 100%;
    background-color: #f9f9f9;
    box-sizing: border-box;
    transition: border 0.3s ease;
}

input:focus, textarea:focus, select:focus {
    border-color: #007BFF;
    outline: none;
}

/* Button styles */
button {
    padding: 12px 20px;
    border-radius: 8px;
    background-color: #007BFF;
    color: #fff;
    font-size: 1.1rem;
    border: none;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
    box-shadow: 0px 4px 10px rgba(0, 123, 255, 0.2);
}

button:hover {
    background-color: #0056b3;
    transform: translateY(-2px);
}

button:disabled {
    background-color: #aaa;
    cursor: not-allowed;
}

/* Table styles */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 30px;
}

table th, table td {
    padding: 12px 15px;
    text-align: left;
    border-bottom: 1px solid #ddd;
    font-size: 1rem;
    color: #555;
}

table th {
    background-color: #f4f4f4;
    font-weight: bold;
    color: #333;
}

table tbody tr:nth-child(even) {
    background-color: #f9f9f9;
}

table tbody tr:hover {
    background-color: #f1f1f1;
    cursor: pointer;
}

/* Action buttons in the table */
.actions {
    display: flex;
    gap: 10px;
}

.actions button {
    padding: 8px 12px;
    border-radius: 8px;
    font-size: 0.9rem;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.2s ease;
}

.actions .edit {
    background-color: #FFC107;
    color: white;
}

.actions .edit:hover {
    background-color: #E0A800;
    transform: translateY(-2px);
}

.actions .complete {
    background-color: #28A745;
    color: white;
}

.actions .complete:hover {
    background-color: #218838;
    transform: translateY(-2px);
}

.actions .delete {
    background-color: #DC3545;
    color: white;
}

.actions .delete:hover {
    background-color: #C82333;
    transform: translateY(-2px);
}

/* Responsive styles */
@media (max-width: 768px) {
    .container {
        padding: 20px;
    }

    h1 {
        font-size: 2rem;
    }

    form {
        gap: 15px;
    }

    button {
        font-size: 1rem;
    }

    table th, table td {
        font-size: 0.9rem;
        padding: 10px;
    }

    table tbody tr td:last-child {
        display: flex;
        justify-content: space-between;
    }
}

</style>

</head>
<body>
<body>
    <div class="container">
        <h1>Uffizio Task</h1>

        <!-- Add/Edit Task Form -->
        <form id="task-form">
            <h2 id="form-title">Add a New Task</h2>
            <input type="hidden" id="task-id">

            <label for="title">Task Title:</label>
            <input type="text" id="title" name="title" placeholder="Enter task title" required>

            <label for="description">Description:</label>
            <textarea id="description" name="description" placeholder="Enter task description"></textarea>

            <label for="dueDate">Due Date:</label>
            <input type="date" id="dueDate" name="dueDate" required>

            <label for="priority">Priority:</label>
            <select id="priority" name="priority">
                <option value="LOW">Low</option>
                <option value="MEDIUM">Medium</option>
                <option value="HIGH">High</option>
            </select>

            <button type="submit" id="form-button">Add Task</button>
        </form>

        <!-- Task List -->
        <div id="task-list">
            <h2>All Tasks</h2>
            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Due Date</th>
                        <th>Priority</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Dynamic Task Rows -->
                </tbody>
            </table>
        </div>
    </div>

    <script src="script.js"></script>
</body>



<script>
var apiUrl = "http://localhost:8080";
$(document).ready(function () {
   

    // Fetch and display tasks
    function fetchTasks() {
    $.get(apiUrl + "/Task/getAll", function (tasks) {
        let rows = ""; 

        tasks.forEach(function (task) {
            rows += "<tr>" +
                "<td>" + task.title + "</td>" +
                "<td>" + (task.description || "-") + "</td>" +
                "<td>" + task.dueDate + "</td>" +
                "<td>" + task.priority + "</td>" +
                "<td>" + task.status + "</td>" +
                "<td class='actions'>" +
                    "<button class='edit' data-id='" + task.id + "'>Edit</button>" +
                    "<button class='complete' data-id='" + task.id + "'" +
                    (task.status == "COMPLETED" ? " disabled" : "") + ">Mark Complete</button>" +
                    "<button class='delete' data-id='" + task.id + "'>Delete</button>" +
                "</td>" +
            "</tr>";
        });

        $("table tbody").html(rows); // Update the table body with the generated rows
    });
}



    // Add or update task
    $("#task-form").submit(function (e) {
        e.preventDefault();

        const taskData = {
            title: $("#title").val(),
            description: $("#description").val(),
            dueDate: $("#dueDate").val(),
            priority: $("#priority").val(),
            status: "PENDING"
        };

        const taskId = $("#task-id").val();
        const method = taskId ? "PUT" : "POST";
        const url = taskId ? `${apiUrl}/Task/update/`+taskId : `${apiUrl}/Task/SaveTask`;

        $.ajax({
            url: url,
            type: method,
            contentType: "application/json",
            data: JSON.stringify(taskData),
            success: function () {
                alert(taskId ? "Task updated successfully!" : "Task added successfully!");
                $("#task-form")[0].reset();
                $("#form-title").text("Add a New Task");
                $("#form-button").text("Add Task");
                fetchTasks();
            }
        });
    });

    // Edit task
    $(document).on("click", ".edit", function () {
        var id = $(this).attr("data-id");
        $.get(`${apiUrl}/Task/get/`+id, function (task) {
            $("#task-id").val(task.id);
            $("#title").val(task.title);
            $("#description").val(task.description);
            $("#dueDate").val(task.dueDate);
            $("#priority").val(task.priority);
            $("#form-title").text("Edit Task");
            $("#form-button").text("Update Task");
        });
    });

    // Mark task as complete
    $(document).on("click", ".complete", function () {
        var id = $(this).attr("data-id");
        $.ajax({
            url: `${apiUrl}/Task/markComplete/`+id,
            type: "PATCH",
            success: function () {
                alert("Task marked as completed!");
                fetchTasks();
            }
        });
    });

    // Delete task
    $(document).on("click", ".delete", function () {
        var id = $(this).attr("data-id");
        $.ajax({
            url: `${apiUrl}/Task/delete/`+id,
            type: "DELETE",
            success: function () {
                alert("Task deleted successfully!");
                fetchTasks();
            }
        });
    });

    fetchTasks();
});

//Mark task as complete
$(document).on("click", ".complete", function () {
    var id = $(this).attr("data-id");
    $.ajax({
        url: `${apiUrl}/Task/markComplete/` + id,  // Updated URL path
        type: "PATCH",
        success: function () {
            alert("Task marked as completed!");
            fetchTasks(); // Refresh the task list to show the updated status
        },
        error: function () {
            alert("Error marking the task as completed. Please try again.");
        }
    });
});
</script>
</html>
