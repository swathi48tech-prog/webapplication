// Form validation and client-side scripts

// Login form validation
if (document.getElementById('loginForm')) {
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        const email = document.getElementById('email').value;
        const password = document.getElementById('password').value;
        const messageDiv = document.getElementById('message');
        
        // Basic validation
        if (!email || !password) {
            e.preventDefault();
            showMessage('Please fill in all fields', 'error');
            return false;
        }
        
        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            e.preventDefault();
            showMessage('Please enter a valid email address', 'error');
            return false;
        }
    });
}

// Registration form validation
if (document.getElementById('registerForm')) {
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const fullname = document.getElementById('fullname').value;
        const email = document.getElementById('email').value;
        const phone = document.getElementById('phone').value;
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const course = document.getElementById('course').value;
        const messageDiv = document.getElementById('message');
        
        // Basic validation
        if (!fullname || !email || !phone || !password || !confirmPassword || !course) {
            e.preventDefault();
            showMessage('Please fill in all fields', 'error');
            return false;
        }
        
        // Email validation
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(email)) {
            e.preventDefault();
            showMessage('Please enter a valid email address', 'error');
            return false;
        }
        
        // Phone validation
        const phoneRegex = /^[0-9]{10}$/;
        if (!phoneRegex.test(phone.replace(/\D/g, ''))) {
            e.preventDefault();
            showMessage('Please enter a valid 10-digit phone number', 'error');
            return false;
        }
        
        // Password validation
        if (password.length < 6) {
            e.preventDefault();
            showMessage('Password must be at least 6 characters long', 'error');
            return false;
        }
        
        // Confirm password validation
        if (password !== confirmPassword) {
            e.preventDefault();
            showMessage('Passwords do not match', 'error');
            return false;
        }
    });
}

// Show message function
function showMessage(message, type) {
    const messageDiv = document.getElementById('message');
    if (messageDiv) {
        messageDiv.textContent = message;
        messageDiv.className = 'message ' + type;
        messageDiv.style.display = 'block';
        
        // Hide message after 5 seconds
        setTimeout(function() {
            messageDiv.style.display = 'none';
        }, 5000);
    }
}

// Check URL parameters for messages
window.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const error = urlParams.get('error');
    const success = urlParams.get('success');
    
    if (error) {
        showMessage(decodeURIComponent(error), 'error');
    }
    
    if (success) {
        showMessage(decodeURIComponent(success), 'success');
    }
});
