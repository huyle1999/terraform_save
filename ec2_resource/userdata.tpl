#!/bin/bash
            echo "${var.server_text}" > index.html
            nohup busybox httpd -f -p "${var.http_port}" &
