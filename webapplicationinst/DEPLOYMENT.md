# Quick Deployment Guide - Training Portal

## WAR File Creation (Manual Steps)

Since compilation requires Java JDK and network access, follow these steps on your local machine:

### Prerequisites on Your Machine

1. **Install JDK 8 or higher**
   - Download from: https://www.oracle.com/java/technologies/downloads/
   - Or use OpenJDK: https://openjdk.org/

2. **Download Tomcat** (if not already installed)
   - Download from: https://tomcat.apache.org/
   - Extract to a directory (e.g., C:\tomcat or /opt/tomcat)

3. **Download Oracle JDBC Driver**
   - Download ojdbc8.jar or ojdbc11.jar from:
     https://www.oracle.com/database/technologies/appdev/jdbc-downloads.html
   - Place in Tomcat's lib directory: {TOMCAT_HOME}/lib/

### Step-by-Step Build Process

#### Step 1: Prepare Directory Structure

Extract the training-website folder and verify this structure:

```
training-website/
├── META-INF/
│   └── context.xml
├── WEB-INF/
│   ├── web.xml
│   └── classes/
│       └── com/trainingportal/
│           ├── DatabaseUtil.java
│           ├── Student.java
│           ├── LoginServlet.java
│           ├── RegisterServlet.java
│           ├── LogoutServlet.java
│           └── CoursesServlet.java
├── css/
│   └── style.css
├── js/
│   └── script.js
├── database/
│   └── schema.sql
├── *.html files
└── build.sh
```

#### Step 2: Compile Java Classes

**On Windows:**
```batch
cd training-website

set TOMCAT_HOME=C:\tomcat
set ORACLE_JDBC=C:\path\to\ojdbc8.jar

javac -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%ORACLE_JDBC%" ^
      -d WEB-INF\classes ^
      WEB-INF\classes\com\trainingportal\*.java
```

**On Linux/Mac:**
```bash
cd training-website

export TOMCAT_HOME=/opt/tomcat
export ORACLE_JDBC=/path/to/ojdbc8.jar

javac -cp "$TOMCAT_HOME/lib/servlet-api.jar:$ORACLE_JDBC" \
      -d WEB-INF/classes \
      WEB-INF/classes/com/trainingportal/*.java
```

#### Step 3: Remove Source Files (Keep Only .class Files)

**On Windows:**
```batch
del /S WEB-INF\classes\*.java
```

**On Linux/Mac:**
```bash
find WEB-INF/classes -name "*.java" -delete
```

#### Step 4: Create WAR File

**On Windows:**
```batch
jar -cvf training-portal.war META-INF WEB-INF css js *.html
```

**On Linux/Mac:**
```bash
jar -cvf training-portal.war META-INF WEB-INF css js *.html
```

Or use the build script:
```bash
chmod +x build.sh
./build.sh
```

### Step 5: Configure Oracle Database

1. **Create Database User:**
```sql
CREATE USER training_user IDENTIFIED BY YourPassword123;
GRANT CONNECT, RESOURCE TO training_user;
GRANT CREATE SESSION TO training_user;
GRANT UNLIMITED TABLESPACE TO training_user;
```

2. **Run Schema Script:**
```bash
sqlplus training_user/YourPassword123@localhost:1521/XE
SQL> @database/schema.sql
SQL> exit;
```

### Step 6: Update Configuration

Edit `META-INF/context.xml` before creating WAR:

```xml
<Resource name="jdbc/OracleDS"
          ...
          url="jdbc:oracle:thin:@YOUR_HOST:1521:YOUR_SID"
          username="training_user"
          password="YourPassword123"
          .../>
```

Replace:
- YOUR_HOST: Your database host (localhost or IP)
- YOUR_SID: Your Oracle SID (XE, ORCL, etc.)
- password: Your actual password

### Step 7: Deploy to Tomcat

1. **Copy WAR file:**
```bash
cp training-portal.war $TOMCAT_HOME/webapps/
```

2. **Ensure Oracle JDBC driver is in Tomcat lib:**
```bash
cp ojdbc8.jar $TOMCAT_HOME/lib/
```

3. **Start Tomcat:**

**On Windows:**
```batch
%TOMCAT_HOME%\bin\startup.bat
```

**On Linux/Mac:**
```bash
$TOMCAT_HOME/bin/startup.sh
```

4. **Access Application:**
- URL: http://localhost:8080/training-portal/
- Login with test account:
  - Email: test@example.com
  - Password: test123

### Step 8: Verify Deployment

Check Tomcat logs:
```bash
tail -f $TOMCAT_HOME/logs/catalina.out
```

Look for:
- "Deploying web application"
- No errors about database connection
- Application started successfully

### Troubleshooting

**Problem: ClassNotFoundException: oracle.jdbc.OracleDriver**
- Solution: Copy ojdbc8.jar to {TOMCAT_HOME}/lib/

**Problem: Cannot create JDBC driver of class**
- Solution: Check context.xml configuration
- Verify Oracle is running: `lsnrctl status`

**Problem: Login fails**
- Solution: Check database has data:
  ```sql
  SELECT * FROM students;
  ```

**Problem: 404 Not Found**
- Solution: Check WAR file deployed successfully
- Look in {TOMCAT_HOME}/webapps/training-portal/

## Quick Test Commands

After deployment, test these URLs:

1. Home page: http://localhost:8080/training-portal/
2. Login page: http://localhost:8080/training-portal/login.html
3. Courses page: http://localhost:8080/training-portal/courses.html
4. Register page: http://localhost:8080/training-portal/register.html

## Production Checklist

Before going to production:

- [ ] Change database credentials in context.xml
- [ ] Implement password hashing (BCrypt)
- [ ] Enable HTTPS/SSL
- [ ] Set up database backups
- [ ] Configure connection pool properly
- [ ] Add input validation
- [ ] Implement CSRF protection
- [ ] Set up logging
- [ ] Configure error pages
- [ ] Test all functionality

## Support

For issues:
- Check README.md for detailed documentation
- Review Tomcat logs in logs/catalina.out
- Verify Oracle database is running and accessible
- Test database connection separately

## Files Included

- All HTML pages (index, login, register, courses, dashboard)
- CSS styling (css/style.css)
- JavaScript (js/script.js)
- Java Servlets (6 servlets)
- Database schema (database/schema.sql)
- Configuration files (web.xml, context.xml)
- Documentation (README.md)
- Build script (build.sh)

---
**Note**: This application is for educational/demonstration purposes.
For production use, implement proper security measures.
