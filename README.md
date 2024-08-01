# Docker WordPress (with PostgreSQL) in Paranoid Mode Environment

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

This software doesn't have a QA Process. This software is a Proof of Concept.

For more information please visit http://www.telefonica.com

## About

This PoC automatize all the steps in order to build a docker enviroment securized with Latch and WordPress in Paranoid Mode (scripts and triggers).

## Requirements

a) Your favorite Linux distro

b) Docker: https://docs.docker.com/install/linux/docker-ce/ubuntu/

c) Docker Compose: https://docs.docker.com/compose/install/

## Installation

1. Open your Latch developer account and create a new application.

2. Clone this repository (take care of the branch you are cloning):

```bash
git clone https://github.com/Telefonica/Docker-WPM-Environment.git
```

3. Modify the `docker-compose.yml` file adding your Latch app id and secret (generated at step 1) in the `LATCH_APP_ID` and `LATCH_SECRET` variables.

4. Set up the environment by running the following command:

```bash
docker-compose up -d --build
```

5. Two docker containers should be created, **dbwpm** (PstgreSQL) and **wpm** (WordPress with the PG4WP dependency and Latch plugin)

6. Open [localhost:8000](http://localhost:8000) in your web browser and follow the WordPress installation steps.

7. Run the following command to install WPM in PostgreSQL container (dbwpm):

```bah
docker exec -it dbwpm ./install.py
```

8. Type the token (you can generate it from the Latch app) when asked during the script execution to pair the new application created at step 1.

9. To avoid any issue, close and open the web browser before log in again to Wordpress ([localhost:8000](http://localhost:8000)).

10. Test the new WPM capabilities from the Latch mobille application (you will find some 'sub-latches')

11. Enjoy!

</br>
<hr>
</br>

<div align="center">
<span>Made with ❤️ by <b>Ideas Locas - Discovery - CDO</b></span>
</div>
