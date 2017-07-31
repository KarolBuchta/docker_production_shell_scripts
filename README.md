# Docker helper scripts for production

## Note: Not in production for us right now, working on it.

### docker_compose_production.sh

You can use this script as an alias in your shell.


It will avoid the execution of the following command, and print a warning instead.

```
  docker-compose down -v
  docker-compose down --volumes
```

The execution will be continued, but without the -v/--volumes arguments. 

Copy the shell file to your desired location
```
  chmod +x docker_compose_production.sh && cp docker_compose_production.sh /usr/local/bin/
```

Add this as an alias in your shell config (e.g. ~/.zshrc, ~/.bashrc)

```
  alias docker-compose='/usr/local/bin/docker_compose_production.sh docker-compose'
```

The script was tested with
* zsh
* bash
* dash

### docker_clean_dangling_unnamed_volumes_production.sh

This script simply deletes all dangling volumes that are not named. It does so by the two following criteria:

* The volume name does not contain an underscore
* The volume name is at least 64 characters long

The script was tested with
* zsh
* bash
* dash

### Disclaimer

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.