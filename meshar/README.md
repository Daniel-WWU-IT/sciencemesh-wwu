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
