## Docker WordPress in Paranoid Mode Environment

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

This software doesn't have a QA Process. This software is a Proof of Concept.

For more information please visit http://www.elevenpaths.com


**About**

This PoC automatize all the steps in order to build a docker enviroment securized with Latch and WordPress in Paranoid Mode (scripts and triggers).

**Prerequisites**

a) Your favorite Linux distro

b) Docker: https://docs.docker.com/install/linux/docker-ce/ubuntu/

c) Docker Compose: https://docs.docker.com/compose/install/


**Steps:**

1. Open your Latch developer account and create a new application. 


2. Download folder


3. Modify the file docker-compose.yml adding your Latch App key at variable LATCHAPPID and the secret key at LATCHSECRET generated at step 1.


4. Run:
```
sudo docker-compose up
```


5. Two docker containers should be created, **dbwpm** (mysql) and **wpm** (WordPress) 


6. Open at your current browser the follwing URL and follow the steps to install WordPress normally:
```
localhost:8000
```


7. Run the following command to install WPM in mysql container:
```
sudo docker exec -it dbwpm ./install.sh
```


8. Type the token (you can generate it from the Latch mobile application) when asked during the script execution to pair the new application created at step 1.


9. To avoid any issue, close and open the web browser before log in again to Wordpress (localhost:8000) url.


10. Test the new WPM capabilities from the Latch mobille application.


11. Enjoy!


By IdeasLocas CDO Team
