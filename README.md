# irnas-otii-software
Scripts for use with Otii power analyzer https://www.qoitech.com/

## Saleae Logic import into Otii Log toolbox
Saleae https://www.saleae.com/ Logic 2 software is a great tool to explore communication protocols. Once you put those next to the power consumption and UART logs in Otii software (Note Log toolbox liecnse required), debugging becomes much easier. Here is how to go about it:

Once you have the CSV file, it needs the first line to be modified for import into Otii software to align the timestamps.

Save the 'saleae.lua' script to the Otii software folder for scripts as per https://www.qoitech.com/docs/user-manual/log-toolbox documentation. On Linux this might be in '/usr/bin/otii-data/scripts/converters/log/', note sudo access will be required.

Open the Otii software, Log in, Reserve the license and capture/load the power consumption data at the same time as the Logic 2 capture. Once both captures are completed, here is how to put them together:

Find out what the starting time of the Otii capture is, might be easiest at looking at UART logs with Display option 'Show wall time' selected. Note that unfortunately there might not be a log print available at capture time 0.

![image](https://user-images.githubusercontent.com/1584734/163723416-c6365840-4124-427e-b403-80c320a41840.png)

Export logs from Logic 2 software protocol analyer with ISO8601 timestamp option to CSV.
![image](https://user-images.githubusercontent.com/1584734/163723127-455104cd-9529-4bdb-9966-cde4f632283c.png)
![image](https://user-images.githubusercontent.com/1584734/163723138-740f312f-ff4b-43f3-bb95-201a8f69aaf9.png)

Then replace the header of the capture with the following line, but ontaining your Otii capture log time:
'"align","align",2022-04-17T09:46:45.889+00:00,,,' This will align the imported data to the power capture.

The last remaining step is to right click on the Recording in Otii software and select 'Import log', select the 'saleae.lua' timestamp converter and import.

![image](https://user-images.githubusercontent.com/1584734/163723553-f82dfdc5-a0f2-4f27-b756-a35dae20f0d9.png)

Final output of the process is having a logic trace, for example SPI aligned with power consumption.
![image](https://user-images.githubusercontent.com/1584734/163723601-3a9bc36c-34a3-4655-a280-6bcae1571c6f.png)

