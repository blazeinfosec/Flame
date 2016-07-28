## Flame

Flame is a SIEM integration tool that enables security professionals to import scanner vulnerability reports into popular SIEMs.

The vulnerability scanners currently supported are Arachni, Burp, OpenVAS and OWASP ZAP.


## Installation

Clone the repository

```
git clone https://github.com/blazeinfosec/Flame.git
```

## Dependencies

In order to get things working, please make sure that Nokogiri and Optarse libraries are
installed.

```
gem install nokogiri
gem install optparse
```

## Limitations

Currently it can only integrate vulnerability reports into Splunk. Support for Elastic Search and Arcsight will be added in the next release of this tool.

## Usage

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

## Sample usage - Importing OpenVAS report to Splunk

## Flame
![Sample screenshot](https://raw.githubusercontent.com/blazeinfosec/Flame/master/resources/images/flame_arachni.png)

## Splunk 
![Sample screenshot](https://raw.githubusercontent.com/blazeinfosec/Flame/master/resources/images/splunk_01.png)


## Author

* **Tiago Ferreira** - tiago at blazeinfosec dot com
* **Company** - [Blaze Information Security](https://www.blazeinfosec.com)

## License 

This project is licensed under the Apache License - see the [LICENSE](LICENSE) file for details
