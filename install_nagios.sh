#Step 1: Install Prerequisite Software
#Nagios requires the following packages are installed on your server prior to installing Nagios:

#* Apache
#* PHP
#* GCC compiler
#* GD development libraries 
#--------------------------------------------------

            sudo yum install httpd php -y
            sudo yum install gcc glibc glibc-common -y
            sudo yum install gd gd-devel -y

# set up a Nagios user ----------------------------

            sudo adduser -m nagios
            sudo passwd nagios

# Create a directory for storing the downloads-----

            mkdir ~/downloads
            cd ~/downloads

# Download Nagios && Plugins

            wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.3.tar.gz
            wget https://nagios-plugins.org/download/nagios-plugins-2.2.1.tar.gz

# Extract the Nagios source code

            tar zxvf nagios-4.4.3.tar.gz
            cd nagios-4.4.3

# Run the configuration script

            ./configure --with-command-group=nagcmd

# Compile the Nagios source code

            make all

            # Install binaries,
            # init script, sample config files and 
            # set permissions on the external command directory.
            sudo make install
            sudo make install-init
            sudo make install-config
            sudo make install-commandmode
            sudo make install-webconf 

# Change E-Mail address with nagiosadmin 

            #-------------------emil in env var-----------------------
            echo "Enter Your Admin Email To Configure Contact :"
            read email
            echo "your email is $email
            "
            export nagios_email
            nagios_email=$email
            bash 

            sudo echo '
            define contact {

                contact_name            nagiosadmin             ; Short name of user
                use                     generic-contact         ; Inherit default values from generic-contact template (defined above)
                alias                   Nagios Admin            ; Full name of user
                email                   '$nagios_email' ; <<***** CHANGE THIS TO YOUR EMAIL ADDRESS ******
            }

            define contactgroup {

                contactgroup_name       admins
                alias                   Nagios Administrators
                members                 nagiosadmin
            }

            ' > /usr/local/nagios/etc/objects/contacts.cfg
            #-------------------emil in env var-----------------------

# Create a nagiosadmin account for logging into the Nagios web interface

            sudo htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin       
            sudo service httpd restart  

# Compile and Install the Nagios Plugins    

            cd ~/downloads
            tar zxvf nagios-plugins-2.2.1.tar.gz
            cd nagios-plugins-2.2.1

# Compile and install the plugins

            ./configure --with-nagios-user=nagios --with-nagios-group=nagios
            make
            sudo make install
# Start Nagios

            sudo chkconfig --add nagios
            sudo chkconfig nagios on

# Verify the sample Nagios configuration files

            sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

# If there are no errors, start Nagios.

            sudo service nagios start

            
# Download NRPE in to your Download directory with curl:

            cd ~/downloads
            curl -L -O https://github.com/NagiosEnterprises/nrpe/releases/download/nrpe-4.1.0/nrpe-4.1.0.tar.gz

        
# Extract the NRPE archive:

            tar zxf nrpe-4.1.0.tar.gz
            cd nrpe-4.1.0/
# Configure

            ./configure

# Now build and install check_nrpe plugin:

            make check_nrpe
            sudo make install-plugin

# Configuring Nagios

        #Uncomment line
        #cfg_dir=/usr/local/nagios/etc/servers
       
        sudo cd /usr/local/nagios/etc/
        sudo mv nagios.cfg oldd
        wget https://raw.githubusercontent.com/abdullah01455/Nagios-install/main/nagios.cfg
        sudo rm -r oldd
        sudo mkdir /usr/local/nagios/etc/servers

        
