# Training Portal - Quick Start Guide

## What You've Received

A complete web application similar to visualpath.in with:
- ✅ Student Login/Registration System
- ✅ Course Catalog
- ✅ Student Dashboard
- ✅ Oracle Database Backend (using OracleDS datasource)
- ✅ Responsive HTML/CSS Frontend
- ✅ Java Servlet Backend
- ✅ Ready for Tomcat Deployment

## File Structure

```
training-portal-webapp.tar.gz
└── training-website/
    ├── *.html              # All web pages (index, login, register, courses, etc.)
    ├── css/style.css       # Styling
    ├── js/script.js        # Client-side JavaScript
    ├── META-INF/
    │   └── context.xml     # Oracle DataSource configuration
    ├── WEB-INF/
    │   ├── web.xml         # Servlet mappings
    │   └── classes/com/trainingportal/
    │       ├── DatabaseUtil.java
    │       ├── Student.java
    │       ├── LoginServlet.java
    │       ├── RegisterServlet.java
    │       ├── LogoutServlet.java
    │       └── CoursesServlet.java
    ├── database/
    │   └── schema.sql      # Oracle database schema
    ├── build.sh            # Linux/Mac build script
    ├── build.bat           # Windows build script
    ├── README.md           # Detailed documentation
    └── DEPLOYMENT.md       # Step-by-step deployment guide
```

## 🚀 Quick Deploy (5 Steps)

### Step 1: Extract Files
```bash
tar -xzf training-portal-webapp.tar.gz
cd training-website
```

### Step 2: Setup Oracle Database
```bash
# Connect to Oracle
sqlplus your_user/your_password@localhost:1521/XE

# Run schema script
SQL> @database/schema.sql
SQL> exit;
```

### Step 3: Configure Database Connection

Edit `META-INF/context.xml`:
```xml
<Resource name="jdbc/OracleDS"
          url="jdbc:oracle:thin:@localhost:1521:XE"
          username="your_username"
          password="your_password" />
```

### Step 4: Build WAR File

**On Linux/Mac:**
```bash
export TOMCAT_HOME=/path/to/tomcat
export ORACLE_JDBC=/path/to/ojdbc8.jar
chmod +x build.sh
./build.sh
```

**On Windows:**
```batch
set TOMCAT_HOME=C:\tomcat
set ORACLE_JDBC=C:\ojdbc8.jar
build.bat
```

### Step 5: Deploy to Tomcat

```bash
# Copy WAR to Tomcat
cp training-portal.war $TOMCAT_HOME/webapps/

# Copy Oracle JDBC driver
cp ojdbc8.jar $TOMCAT_HOME/lib/

# Start Tomcat
$TOMCAT_HOME/bin/startup.sh
```

## 🌐 Access Application

**URL:** http://localhost:8080/training-portal/

**Test Login Credentials:**
- Email: test@example.com
- Password: test123

## 📋 Prerequisites Checklist

- [ ] JDK 8+ installed
- [ ] Apache Tomcat 8.5+ installed
- [ ] Oracle Database running
- [ ] Oracle JDBC Driver (ojdbc8.jar) downloaded
- [ ] Database user created with proper permissions

## 🎯 Key Features

### Student Features:
- ✓ Registration with email validation
- ✓ Secure login (session-based)
- ✓ Course browsing
- ✓ Personal dashboard
- ✓ Course enrollment tracking

### Technical Features:
- ✓ Oracle Database with JNDI DataSource (OracleDS)
- ✓ Connection pooling configured
- ✓ Prepared statements (SQL injection safe)
- ✓ Session management
- ✓ Responsive design
- ✓ Professional UI similar to visualpath.in

## 📚 Database Schema

The application uses 3 main tables:
- `STUDENTS` - Student information
- `COURSES` - Course catalog
- `ENROLLMENTS` - Student-course relationships

All tables have auto-increment IDs using Oracle sequences.

## 🔧 Common Issues & Solutions

**Problem:** ClassNotFoundException: oracle.jdbc.OracleDriver
**Solution:** Copy ojdbc8.jar to $TOMCAT_HOME/lib/

**Problem:** Cannot get JDBC connection
**Solution:** 
- Check Oracle is running: `lsnrctl status`
- Verify connection details in context.xml
- Test connection: `sqlplus user/pass@host:port/sid`

**Problem:** 404 Error
**Solution:** 
- Check WAR deployed: ls $TOMCAT_HOME/webapps/training-portal/
- Check Tomcat logs: tail -f $TOMCAT_HOME/logs/catalina.out

## 📖 Documentation

- **README.md** - Complete documentation with all features
- **DEPLOYMENT.md** - Detailed deployment instructions
- **database/schema.sql** - Database structure and sample data

## 🔐 Security Notes

**For Production:**
1. ⚠️ Implement password hashing (currently plain text)
2. ⚠️ Enable HTTPS/SSL
3. ⚠️ Add CSRF protection
4. ⚠️ Implement rate limiting
5. ⚠️ Add input sanitization

## 💡 Next Steps

1. Customize the design and branding
2. Add more courses to the database
3. Implement payment gateway
4. Add admin panel
5. Create email notifications
6. Add certificate generation
7. Implement video streaming for courses

## 📞 Support

Check the included documentation:
- README.md for detailed features
- DEPLOYMENT.md for deployment steps
- Database schema comments in schema.sql

## 🎓 Sample Data Included

- 6 pre-configured courses
- 2 test student accounts
- Complete database schema with constraints
- Auto-increment sequences configured

---

**Ready to Deploy!** Just follow the 5 steps above and you'll have a fully functional training portal running on Tomcat with Oracle database.

For detailed information, refer to README.md and DEPLOYMENT.md files included in the package.
