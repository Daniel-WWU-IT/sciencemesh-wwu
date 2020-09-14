# MESHAR
The **Mesh** **A**vailability & **R**eliability tool chain is a set of applications used to monitor the health of the sites and their respective services in the ScienceMesh.

## Design
Various design considerations can be found in `design`.

## CheckMK
[CheckMK](https://checkmk.com) is currently evaluated as a monitoring platform. Various scripts and Docker files can be found in `checkmk`.

### Evaluation
The following list contains first results in no particular order from the evaluation:

- Dynamic hosts can be added via an HTTP API
- Remote checks (i.e., probes running on the monitoring server)
    - Own probes possible (Nagios-compliant)
- Easy and extensive local checks
    - Might become interesting at a later stage
- Aggregation of (service) states via Business Intelligence module
    - Can be created dynamically based on hosts or services
- Availability built-in
- Supports scheduled downtimes
    - Offers an external API to schedule them
- User & access management
- Good documentation, but necessary since not intuitive at all
    - Some parts, especially about writing custom probes, are missing
- Free, but comes with no support
    - SLA module not included in free version
    - Email notifications problematic
        - Only SMTP relay server supported
        - Configuration on the OS side, CheckMK simply uses the `sendmail` command
- Notifications (various channels), events, basic logging etc.
- Easy to setup and deploy
- Lots of fine-tuning necessary
- Nagios probes:
    - Easy to integrate
    - First output line is interpreted as the output of the probe, all other output is also shown though
    - Best to have each probe only check for _one_ functionality
    - Can only be used as a "classical check", thus not utilizing any extended features
- Mainly used for local system-level checks, not for remote probing
    - But it works well enough
- Very fine-grained control of every detail, but steep learning curve
- Further possibly interesting features
    - Metrics
    - Performance data
    - Cluster monitoring

## Icinga
[Icinga](https://icinga.com) is another monitoring platform that is being evaluated.

### Evaluation
The following list contains first results in no particular order from the evaluation:

- Fully automatable
    - Configuration via easy yet powerful DSL
- More tailored towards remote checking
- Deployment and setup more laborious
    - Docker containers are available, but haven't been tested
    - Customized containers will most likely be required
    - Due to its support for full automization, configuration is easy once the stack has been deployed
- Nagios-based
    - All existing probes can be used
    - Own probes easy to develop
    - Supports simple statuses and performance data
- Good documentation, but not always easy to follow
- Distributed system
    - Very scalable
    - Harder to understand at first
- Requires an external database system (MySQL/MariaDB or PostgreSQL)
    - A more flexible adapter for other databases is in development
- User-groups/-roles with different access rights
- Offers an optional web interface
    - Modern look & feel
    - Requires a web server
    - Not as "informative" as others
    - Can be extended by many existing addons
    - Usually only used to view, not to modify
        - An addon (director) exists to also modify aspects of the infrastructure
- Powerful scripting capabilities
    - Makes configuration more difficult, but is also more transparent
- All objects (hosts, services, commands, etc.) can be grouped
- Flexible notification mechanisms
    - Powerful rules can be defined
    - Uses external commands to perform notifications
- Business processes to aggregate hosts and services
- Grafana integrations available
- Availability only available through report generation
    - Can be automated    
- Downtimes are supported, but their effect is not clear yet
- Difficult to retrieve the status of hosts and services from "the outside"
    - Custom addons might be required for this
    - Existing addons usually directly access the database
- More development effort needed
    - Addons written in PHP, many "examples" available
    - Such addons can be created to perfectly fit our needs
- Reliability not as easy to calculate
- Free (if used as an on-premise solution)
    - Support is not free

## Comparison
First of all, both CheckMK and Icinga offer pretty much everything needed for the ScienceMesh project. They differ in many aspects, though. The following table tries to compare both candidates (in no particular order):

| CheckMK | Icinga |
| --- | --- |
| _**General**_ | |
| Limited automization | Full automization |
| Easy deployment | More complex deployment |
| Centralized system | Distributed system |
| Not scalable | Easily scalable |
| Free, but not all features available | Free as an on-premise solution |
| Controlling via web interface | Controlling via powerful scripting |
| _**Monitoring**_ | |
| Focus on local checks | Focus on remote checks |
| Nagios probes supported, but not ideal | Nagios probes fully supported |
| Basic notifications | Flexible notifications |
| _**Web interface**_ | |
| Must-have | Optional |
| Outdated look & feel | Modern |
| Highly informative | Less informative |
| Can't be extended | Easy to extend |
| High learning curve | Easy to learn |
| Advanced BI module | Basic BI module |
| Lots of fine tuning | Everything's scripted |
| Hard to understand | Transparent and easy to understand |
| _**Other features**_ | |
| Downtimes supported | Downtimes supported, but more rudimentary |
| Users & Groups | Users & Groups |
| User restrictions | Fully customizable user restrictions |
| No Grafana integration in free version | Grafana integration |
| _**External access**_ | |
| Easy to retrieve information | Not so easy to retrieve information |
| No extra effort needed | Use case-specific addon might be needed |
| _**Additional development**_ | |
| No custom addons | Custom addons for all purposes easy to create |
| _**A&R**_ | |
| Availability included | Availability only in BI reports |
| Reliability easy to calculate | Reliability calculation requires some more work |
| Detailed status statistics | Only current status available |
