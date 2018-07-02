## WordPress in Paranoid Mode, Docker edition (Linux)

1. Open your Latch developer account and create a new application. 

2. Download folder

3. Modify the file docker-compose.yml adding your Latch App key at variable LATCHAPPID and the secret key at LATCHSECRET generated at step 1.

4. Run:
…
sudo docker-compose up
…

5. Two docker containers will be created, dbwpm (mysql) and wpm (WordPress) 

6. Open your current browser and open url localhost:8000 and install WordPress

7. Run the following command to install WPM in mysql container:
...
sudo docker exec -it dbwpm ./install.sh
…

7. Type the token (you can generate it from the Latch mobile application) when asked during the script execution to pair the new application created at step 1.

8 Test the new WPM capabilities from the Latch mobille application.

9 Enjoy!


**PoC created by ElevenPaths**
https://www.elevenpaths.com/
