# Task-1: System Monitoring Setup

## Objective
To configure a monitoring system that ensures the health, performance, and capacity planning of the development environment.

## Scenario
- The development server is experiencing intermittent performance issues.
- New developers require visibility into system resource usage for their tasks.
- System metrics must be consistently tracked for effective capacity planning.

## Requirements
- Install and configure system monitoring tools (`htop` or `nmon`) to track CPU, memory, and process usage.
- Set up disk usage monitoring using `df` and `du`.
- Implement process monitoring to identify resource-intensive applications.
- Establish a basic reporting structure to log system metrics for review.

## Installation and Configuration

### 1. Install Monitoring Tools
#### Install `htop`:
```bash
sudo apt update && sudo apt install -y htop   # Ubuntu/Debian
sudo yum install -y htop                      # CentOS/RHEL
```
#### Install `nmon`:
```bash
sudo apt update && sudo apt install -y nmon   # Ubuntu/Debian
sudo yum install -y nmon                      # CentOS/RHEL
```
#### Run Monitoring Tools
- Start `htop`:
  ```bash
  htop
  ```
- Start `nmon`:
  ```bash
  nmon
  ```
  Press `c` for CPU, `m` for memory, `d` for disk stats.

### 2. Disk Usage Monitoring
#### Check Disk Space Using `df`:
```bash
df -h > /var/log/disk_usage.log
```
#### Check Folder Size Using `du`:
```bash
du -sh /var/log /home > /var/log/folder_usage.log
```

### 3. Process Monitoring
Identify resource-intensive processes using:
```bash
ps aux --sort=-%cpu | head -10 > /var/log/cpu_usage.log
ps aux --sort=-%mem | head -10 > /var/log/mem_usage.log
```

### 4. Automate System Metrics Logging
To automate logging every 10 minutes, add the following cron jobs:
```bash
crontab -e
```
Add:
```bash
*/10 * * * * htop -d 10 -b > /var/log/htop.log
*/10 * * * * df -h > /var/log/disk_usage.log
*/10 * * * * ps aux --sort=-%cpu | head -10 > /var/log/cpu_usage.log
*/10 * * * * ps aux --sort=-%mem | head -10 > /var/log/mem_usage.log
```

## Logging and Reporting
- System logs are stored in `/var/log/`.
- Key log files:
  - `htop.log`: Real-time CPU and memory monitoring.
  - `disk_usage.log`: Disk space monitoring.
  - `cpu_usage.log`: Top CPU-consuming processes.
  - `mem_usage.log`: Top memory-consuming processes.
  - `folder_usage.log`: Storage utilization of key directories.

## Documentation
For troubleshooting and further customization, refer to:
- `man htop`
- `man nmon`
- `man df`
- `man du`
- `man ps`

This setup ensures continuous monitoring, proactive issue resolution, and optimized system performance for the development environment.



# Task-2: User Management and Access Control

## Objective
Set up user accounts and configure secure access controls for new developers, Sarah and Mike.

## Scenario
- Two new developers, Sarah and Mike, require system access.
- Each developer needs an isolated working directory to maintain security and confidentiality.
- Security policies must ensure proper password management and access restrictions.

---

## Step 1: Create User Accounts
Run the following commands to create user accounts with their respective home directories:

```bash
sudo useradd -m -d /home/Sarah Sarah
sudo useradd -m -d /home/mike Mike
```

Set secure passwords for each user:

```bash
sudo passwd Sarah
sudo passwd Mike
```

Enter and confirm a strong password for each user when prompted.

---

## Step 2: Create and Secure Workspace Directories
Ensure each user has a private workspace:

```bash
sudo mkdir -p /home/Sarah/workspace
sudo mkdir -p /home/mike/workspace
```

Set ownership and permissions to restrict access:

```bash
sudo chown Sarah:Sarah /home/Sarah/workspace
sudo chown Mike:Mike /home/mike/workspace

sudo chmod 700 /home/Sarah/workspace
sudo chmod 700 /home/mike/workspace
```

### Permissions Explanation:
- `700` ensures only the respective user can access their directory.

---

## Step 3: Enforce Password Policies
Edit the password policy configuration file:

```bash
sudo nano /etc/login.defs
```

Ensure the following parameters are set:

```
PASS_MAX_DAYS   30
PASS_MIN_DAYS   2
PASS_WARN_AGE   7
```

Apply the policy to Sarah and Mike:

```bash
sudo chage -M 30 -m 2 -W 7 Sarah
sudo chage -M 30 -m 2 -W 7 Mike
```

### Enforce Password Complexity Rules
Install and configure `libpam-pwquality`:

```bash
sudo apt install libpam-pwquality  # For Debian/Ubuntu
sudo yum install pam_pwquality     # For RHEL/CentOS
```

Edit the PAM password quality settings:

```bash
sudo nano /etc/security/pwquality.conf
```

Set rules for password complexity:

```
minlen = 12
dcredit = -1
ucredit = -1
lcredit = -1
ocredit = -1
```

### Rule Explanation:
- At least **one digit**, **one uppercase**, **one lowercase**, and **one special character**.

---

## Step 4: Verify Setup
To check users and their password policies:

```bash
sudo ls -ld /home/Sarah/workspace /home/mike/workspace
sudo chage -l Sarah
sudo chage -l Mike
```

---

## Conclusion
By following these steps, we have:
- Created secure user accounts for Sarah and Mike.
- Ensured isolated and protected workspaces.
- Enforced strong password policies with expiration rules.

This setup improves system security while providing controlled access for new developers.

