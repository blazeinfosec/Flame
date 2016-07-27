# Flame

Flame is a SIEM integration tool that enables security professionals to import scanner vulnerabilities reports into the Splunk, Elastic Search and others SIEMs. At the present time this release only works with Splunk as SIEM, the next release will accept Elastic Search and Arcsight as well. 

The currently vulnerability scanners supported is Arachni, Burp, Openvas and OwaspZAP.


# Install 

Clone Flame repository

```
git clone https://github.com/blazeinfosec/Flame.git
```

In order to get the things working, please make sure that Nokogiri and Optarse libraries are
installed.

```
gem install nokogiri
gem install optparse
```

# Run Flame

```
tiago@blazesecurity:~/blaze/wildfire/tools/flame$ ./flame.rb 

[*] Flame - Send vulnerabilities reports to SIEM

Usage: flame [options]
    -f, --file                       Vulnerability scanner report file (required)
    -n, --tool-name                  Scanner name. Current available tools: Arachni, Burp, Owaspzap, Openvas (required)
        --proxy                      Use HTTP proxy to connect to target SIEM, ex: http://127.0.0.1:8080
        --siem                       SIEM to connect. Current available SIEMs: Splunk 

 Splunk options:
   Configure Splunk specific environment

    -u, --username                   Splunk username (required)
    -p, --password                   Splunk password (required)
    -s, --server                     Splunk ip address or hostname (required)
    -t, --port                       Splunk TCP port (default 8089)
        --token                      Splunk HTTP event collector token. If no token was specified, Flame will generate a new
        --source                     Specify a source name to be used in Splunk (default is Flam

```

# Flame - Importing Openvas report to Splunk

## Flame
![Sample screenshot](https://raw.githubusercontent.com/blazeinfosec/Flame/master/resources/images/flame_arachni.png)

## Splunk 
![Sample screenshot](https://raw.githubusercontent.com/blazeinfosec/Flame/master/resources/images/splunk_01.png)


# Author

* **Tiago Ferreira** - tiago at blazeinfosec dot com
* **Company** - Blaze Information Security (https://www.blazeinfosec.com/)

# License 

This project is licensed under the Apache License - see the [LICENSE](LICENSE) file for details
