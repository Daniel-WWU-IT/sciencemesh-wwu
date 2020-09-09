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
Icinga has not yet been evaluated to a great extend. Below are a few first impressions:

- Focused on automation
    - Powerful REST API
    - Fully configurable via a flexible configuration language
- Distributed monitoring
- Easier to use than CheckMK
    - But less powerful
    - Exact feature list unknown
- Modern interface
    - Not every aspect can be managed using this interface
- Free (if used as an on-premise solution)
    - Support is not free
- Good documentation
- Simple aggregation of services into a single status
- Notifications seem to be supported, but hard to tell what they can do
    - Integration with various DevOps tools
- Uses Nagios probes
- Not sure if users with different roles are supported
- Supports scheduled downtimes
- Seems to not offer Availability out-of-the-box
- More tailored towards external checks

## Sensu
[Sensu](https://sensu.io) is yet another monitoring platform under evaluation.

## Evaluation
Sensu has not yet been evaluated, but already made a few impressions:

- Focused on clouds
- Supports Nagios probes
- Philosophy unknown
    - So far, it is hard to tell how it handles nodes and services
- Free version only supports up to 100 nodes (unsure how these are defined)
- Web interface only offers very few features
    - Seems to be the least comfortable solution
- Might still be worth further investigation
