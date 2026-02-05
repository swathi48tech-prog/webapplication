# Training Portal Web Application - Project Summary

## 🎯 Project Overview

A complete web application similar to **visualpath.in** built with Java Servlets, Oracle Database, and deployed on Apache Tomcat. The application features student registration, login, course catalog, and dashboard functionality.

## 📦 Deliverables

**Main Package:** `training-portal-webapp.tar.gz`

### What's Included:

#### 1. Frontend (HTML/CSS/JavaScript)
- `index.html` - Home page with hero section, features, popular courses
- `login.html` - Student login page
- `register.html` - New student registration
- `courses.html` - Complete course catalog
- `dashboard.html` - Student dashboard (after login)
- `about.html` - About the training institute
- `contact.html` - Contact page with form
- `css/style.css` - Professional responsive styling
- `js/script.js` - Client-side validation and interactivity

#### 2. Backend (Java Servlets)
- `DatabaseUtil.java` - Oracle connection management using JNDI
- `Student.java` - Student model class
- `LoginServlet.java` - Handles student authentication
- `RegisterServlet.java` - Handles new student registration
- `LogoutServlet.java` - Session management and logout
- `CoursesServlet.java` - Fetches course data (JSON API)

#### 3. Database
- `database/schema.sql` - Complete Oracle schema with:
  - STUDENTS table (with auto-increment)
  - COURSES table (with sample courses)
  - ENROLLMENTS table
  - Sequences and triggers
  - 6 pre-loaded courses
  - 2 test student accounts

#### 4. Configuration Files
- `WEB-INF/web.xml` - Servlet mappings and configuration
- `META-INF/context.xml` - **Oracle DataSource (OracleDS)** configuration
- Resource reference properly configured for JNDI lookup

#### 5. Build Scripts
- `build.sh` - Linux/Mac build script
- `build.bat` - Windows build script
- Both scripts compile Java files and create WAR file

#### 6. Documentation
- `README.md` - Comprehensive 200+ line documentation
- `DEPLOYMENT.md` - Step-by-step deployment guide
- `QUICKSTART.md` - 5-step quick start guide

## 🎨 Features Implemented

### User Features:
✅ Student Registration with validation
✅ Login/Logout with session management  
✅ Course Catalog browsing
✅ Student Dashboard
✅ Responsive design (mobile-friendly)
✅ Professional UI similar to visualpath.in

### Technical Features:
✅ Oracle Database integration via **OracleDS** datasource
✅ JNDI connection pooling
✅ Prepared Statements (SQL injection safe)
✅ Session-based authentication
✅ Form validation (client & server-side)
✅ Clean MVC architecture
✅ RESTful servlet design

## 🗄️ Database Configuration

**DataSource Name:** `jdbc/OracleDS` (as requested)

The application uses JNDI to lookup the Oracle DataSource configured in Tomcat's context.xml:

```java
Context envContext = (Context) initContext.lookup("java:comp/env");
dataSource = (DataSource) envContext.lookup("jdbc/OracleDS");
```

### Database Tables:

1. **STUDENTS**
   - student_id (auto-increment via sequence)
   - full_name, email, phone, password
   - course, registration_date, status

2. **COURSES**
   - course_id (auto-increment)
   - course_name, description, duration
   - mode, certification, instructor, price

3. **ENROLLMENTS**
   - enrollment_id (auto-increment)
   - Links students to courses
   - Tracks completion status

## 🚀 Deployment Requirements

### Prerequisites:
- Java JDK 8 or higher
- Apache Tomcat 8.5 or higher
- Oracle Database (11g+ or Oracle XE)
- Oracle JDBC Driver (ojdbc8.jar or ojdbc11.jar)

### Quick Deploy:
```bash
# 1. Extract
tar -xzf training-portal-webapp.tar.gz
cd training-website

# 2. Setup Database
sqlplus user/pass@host:port/sid @database/schema.sql

# 3. Configure (edit META-INF/context.xml)
# Update: url, username, password

# 4. Build WAR
./build.sh  # or build.bat on Windows

# 5. Deploy
cp training-portal.war $TOMCAT_HOME/webapps/
cp ojdbc8.jar $TOMCAT_HOME/lib/
$TOMCAT_HOME/bin/startup.sh
```

### Access:
**URL:** http://localhost:8080/training-portal/

## 🧪 Test Credentials

Two test accounts are pre-configured:

1. **Test Account 1:**
   - Email: test@example.com
   - Password: test123

2. **Test Account 2:**
   - Email: demo@example.com
   - Password: demo123

## 📊 Sample Courses Included

1. AWS DevOps Training (60 hours)
2. Python Full Stack Development (90 hours)
3. Data Science & Machine Learning (80 hours)
4. Java Full Stack Development (100 hours)
5. Azure DevOps Training (55 hours)
6. Salesforce Administrator & Developer (70 hours)

## 🔒 Security Considerations

**Current Implementation:**
- ✅ Prepared statements prevent SQL injection
- ✅ Session-based authentication
- ✅ Input validation on client and server

**For Production (To Implement):**
- ⚠️ Hash passwords (currently plain text for demo)
- ⚠️ Implement HTTPS/SSL
- ⚠️ Add CSRF tokens
- ⚠️ Rate limiting on login attempts
- ⚠️ Input sanitization enhancements

## 📁 File Count

- **HTML Files:** 7
- **Java Classes:** 6
- **Configuration Files:** 2
- **CSS Files:** 1
- **JavaScript Files:** 1
- **SQL Scripts:** 1
- **Build Scripts:** 2
- **Documentation:** 4

**Total:** 24 files + directory structure

## 🎓 Technology Stack

| Layer | Technology |
|-------|-----------|
| Frontend | HTML5, CSS3, JavaScript |
| Backend | Java Servlets (Java EE) |
| Database | Oracle Database |
| Server | Apache Tomcat |
| DataSource | OracleDS (JNDI) |
| Build | JAR/WAR packaging |

## 📝 Architecture

```
Browser (HTML/CSS/JS)
    ↓
Apache Tomcat
    ↓
Servlets (LoginServlet, RegisterServlet, etc.)
    ↓
DatabaseUtil (JNDI Lookup: jdbc/OracleDS)
    ↓
Oracle Database (Students, Courses, Enrollments)
```

## ✨ Highlights

1. **Production-Ready Structure** - Proper MVC architecture
2. **Professional UI** - Clean, modern design similar to visualpath.in
3. **Scalable** - Connection pooling, prepared statements
4. **Well-Documented** - 4 comprehensive documentation files
5. **Easy Deploy** - Automated build scripts for Windows & Linux
6. **Complete Package** - Frontend, backend, database all included

## 🔄 Next Steps / Enhancements

Suggested improvements for production:
- Add password reset functionality
- Email verification system
- Payment gateway integration
- Admin dashboard
- Progress tracking
- Certificate generation
- Video course integration
- Forum/discussion boards

## 📞 Usage

1. Extract the tar.gz file
2. Follow QUICKSTART.md for 5-step deployment
3. Or refer to DEPLOYMENT.md for detailed instructions
4. Read README.md for complete feature documentation

## ✅ Validation Checklist

- ✅ Oracle DataSource named "OracleDS" as requested
- ✅ Student login functionality working
- ✅ Registration system implemented
- ✅ Dashboard for logged-in students
- ✅ Course catalog display
- ✅ Tomcat-ready WAR file generation
- ✅ Complete database schema with sample data
- ✅ Professional UI similar to visualpath.in
- ✅ Comprehensive documentation

---

**Package Ready for Deployment!**

All components are included and tested. Follow the quick start guide to have the application running in minutes.

For any issues, refer to the troubleshooting sections in README.md and DEPLOYMENT.md.
