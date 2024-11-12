# ISP-Watchtower

- [ISP-Watchtower](#isp-watchtower)
  - [Overview](#overview)
    - [High level architecture](#high-level-architecture)
      - [Components](#components)
      - [Diagram](#diagram)
      - [Operation](#operation)
  - [Installation](#installation)

## Overview

This project sets up a simple monitoring solution for home network's Internet Service Provider (ISP) performance. It uses Telegraf, InfluxDB, Grafana ( TIG ) stack, running in containers to collect data using various telegraf plugins and display it in an easy-to-understand graphical interface.

### High level architecture

#### Components

- [InfluxDB](https://www.influxdata.com/products/influxdb-overview/)  is a high-performance time-series database used to store and analyze metrics and events data.
- [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/) is an open-source agent that collects, processes, and sends metrics and data from various sources to different datastores like InfluxDB.
- [Grafana](https://grafana.com/) is an open-source visualization and analytics software used for monitoring and analyzing data from various sources.

#### Diagram

<img src="media/isp-watch.png" height="300">

#### Operation

- Telegraf based on the input plugins will collect data about ping response times, internet speed, and DNS queries etc.
- Telegraf then sends the collected data to InfluxDB, which is a time-series database that stores and organizes the data.
- Grafana is then used to visualize the data collected by Telegraf and stored in InfluxDB, providing real-time monitoring of ping response times, internet speed, and DNS queries.
- Dashboards can be created in Grafana to display the data in a graphical format, for example sample dashboard included in this repo.

|||
|-|-|
|<img src="media/isp-speed.png" height="200"> | <img src="media/isp-dns.png" height="200"> |

NOTE:
> The entire stack can be deployed using docker or podman.
>
> The individual components can be installed as containers or natively as well.

## Installation

- Clone this repository using following command:

```shell
Using SSH
---------
git clone git@github.com:UchihaItachiSama/ISP-Watchtower.git

OR

Using HTTPS
-----------
git clone https://github.com/UchihaItachiSama/ISP-Watchtower.git
```


