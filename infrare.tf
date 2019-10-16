# Configure Datadog provider

variable "datadog_api_key" {
	type = string
}

variable "datadog_app_key" {
	type = string
}

provider "datadog" {
	api_key = "${var.datadog_api_key}"
	app_key = "${var.datadog_app_key}"
}

# Create a new dashboard
resource "datadog_dashboard" "ordered_dashboard" {
	title 		= "General Logging Dashboard"
	description 	= "This dashboard provides metrics on our ingested logs"
	layout_type 	= "ordered"	
	is_read_only	= true

widget {
	alert_graph_definition {
		alert_id = "11701359"
		viz_type = "timeseries"
		title = "Log Ingestion Monitor"
		time = {
			live_span = "1h"
		}
	}
}

widget {
	distribution_definition {
		request {
			q = "sum:TotalLogs{*}"
			style {
				palette = "warm"
			}
		}
		title = "Total Logs (1h)"
		time = {
			live_span = "1h"
		}
	}
}
}
