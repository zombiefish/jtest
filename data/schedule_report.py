from datetime import datetime
import time
import requests
REPORT_SCHEDULER_RUN_HOUR = 6
REPORT_SCHEDULER_RUN_MINUTE = 0
def run_report(RUN):
    print('The Scheduler has been started!!!')
    # change client_api to this to parse from the .env config file for k8s prod
    # start
    with open("/opt/api/sofvie_api/.env") as f:
      for line in f:
        if line.startswith('#') or not line.strip():
          continue
        key, value = line.strip().split('=', 1)
        if key.strip() == "HOST_NAME":
          client_api = value.replace('\'', '').replace('"', '').strip()
          break
    # end
    api_get_report_scheduler_settings = client_api+"api/report-scheduler/get-report-scheduler-run-time-settings/"
    api_report_scheduler = client_api+"api/report-scheduler/E03EDE6657278C27484BA90DA05CAF95DB64E8ADE6AAA9C0438C64092D3A0E12/"
    print(api_get_report_scheduler_settings)
    while RUN:
        try:
            response = requests.get(api_get_report_scheduler_settings)
            all_settings = response.json()['all_settings']
            REPORT_SCHEDULER_RUN_HOUR = all_settings['REPORT_SCHEDULER_RUN_HOUR']
            REPORT_SCHEDULER_RUN_MINUTE = all_settings['REPORT_SCHEDULER_RUN_MINUTE']
        except:
            REPORT_SCHEDULER_RUN_HOUR = 6
            REPORT_SCHEDULER_RUN_MINUTE = 0
        print("REPORT_SCHEDULER_RUN_HOUR", REPORT_SCHEDULER_RUN_HOUR)
        print("REPORT_SCHEDULER_RUN_MINUTE", REPORT_SCHEDULER_RUN_MINUTE)
        if datetime.now().hour == REPORT_SCHEDULER_RUN_HOUR and datetime.now().minute == REPORT_SCHEDULER_RUN_MINUTE:
            RUN = False
            response = requests.get(api_report_scheduler)
            print('The Scheduler triggered the report scheduler endpoint ....')
        time.sleep(60)
        RUN = True
if __name__ == '__main__':
    RUN = True
    run_report(RUN)
