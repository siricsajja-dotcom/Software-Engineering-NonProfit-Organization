// Siri Sajja
// Project name: Assignment 2-C: Analysis and Design
// Description (project): Volunteer Tracker system for logging and viewing volunteer hours
// Filename: A2.js
// Description (contents/purpose): Handles frontend functionality including filtering, check-in/out, and admin actions
// Last modified on: March 30, 2026

document.addEventListener("DOMContentLoaded", function () {
    const filterDropdown = document.getElementById("filterDropdown");

    // Dropdown filter
    filterDropdown.addEventListener("change", function () {
        const value = this.value; // "month", "year", or "all"
        sendRequest(`/history/filter?range=${value}`);
    });

    // Load default table
    sendRequest("/history/filter?range=all");

    // CHECK-IN
    const checkInBtn = document.getElementById("checkInBtn");
    if (checkInBtn) {
        checkInBtn.onclick = function () {
            sendRequest("/hours/checkin");
        };
    }

    // CHECK-OUT
    const checkOutBtn = document.getElementById("checkOutBtn");
    if (checkOutBtn) {
        checkOutBtn.onclick = function () {
            sendRequest("/hours/checkout");
        };
    }

    // ADMIN APPROVE
    const approveBtn = document.getElementById("approveBtn");
    if (approveBtn) {
        approveBtn.onclick = function () {
            sendRequest("/hours/approve");
        };
    }

    // CREATE EVENT
    const createEventBtn = document.getElementById("createEventBtn");
    if (createEventBtn) {
        createEventBtn.onclick = function () {
            sendRequest("/events/create");
        };
    }
});


// Generic request handler
function sendRequest(url) {
    console.log("Request sent to:", url);

    // Simulate backend response (but NOT doing logic here)
    data = simulateBackend(url);

    handleResponse(data);
}

// Handles all responses from backend
function handleResponse(data) {
    if (data.records) {
        updateHistoryTable(data.records);
        updateTotalHours(data.totalHours);
    }

    if (data.message) {
        alert(data.message);
    }
}

// This represents what the Ruby backend would do
function simulateBackend(url) {
    const allRecords = [
        { event_name: "Park Cleanup", date: "2024-08-15", hours: 4 },
        { event_name: "Art Museum Cleanup", date: "2026-03-29", hours: 3 },
        { event_name: "Food Drive", date: "2026-01-01", hours: 2 }
    ];

    let filtered = [];
    const now = new Date();

    if (url.includes("range=month")) {
        const monthAgo = new Date();
        monthAgo.setDate(now.getDate() - 30); // go back 30 days
        filtered = allRecords.filter(r => new Date(r.date) >= monthAgo);
    } else if (url.includes("range=year")) {
        const yearAgo = new Date();
        yearAgo.setFullYear(now.getFullYear() - 1);
        filtered = allRecords.filter(r => new Date(r.date) >= yearAgo);
    } else if (url.includes("range=all")) {
        filtered = allRecords;
    } else if (url.includes("checkin")) {
        return { message: "Checked in successfully" };
    } else if (url.includes("checkout")) {
        return { message: "Checked out successfully" };
    } else if (url.includes("approve")) {
        return { message: "Hours approved" };
    } else if (url.includes("create")) {
        return { message: "Event created" };
    }

    return {
        records: filtered,
        totalHours: filtered.reduce((sum, r) => sum + r.hours, 0)
    };
}

// UI update ONLY (use of AI for updateHistoryTable() function)
function updateHistoryTable(records) {
    table = document.getElementById("historyTable");
    table.innerHTML = "";

    if (!records || records.length === 0) {
        table.innerHTML = "<tr><td colspan='3'>No records found</td></tr>";
        return;
    }

    records.forEach(record => {
        table.innerHTML += `
            <tr>
                <td>${record.event_name}</td>
                <td>${record.date}</td>
                <td>${record.hours}</td>
            </tr>
        `;
    });
}

function updateTotalHours(total) {
    document.getElementById("totalHours").innerText =
        "Total Hours: " + total;
}