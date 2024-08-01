------------------------------------------
-- FUNCTIONS
------------------------------------------
CREATE EXTENSION plpython3u;

CREATE OR REPLACE FUNCTION check_latch(operation VARCHAR) RETURNS BOOLEAN AS $$
from latch import Latch

try:
    operation_to_id = {
        "ReadOnly": "{{READ_ONLY_OPERATION_ID}}",
        "Edition": "{{EDITION_OPERATION_ID}}",
        "Administration": "{{ADMINISTRATION_OPERATION_ID}}"
    }

    latch_instance = Latch("{{LATCH_APP_ID}}", "{{LATCH_SECRET}}")
    response = latch_instance.operation_status("{{ACCOUNT_ID}}", operation_to_id[operation])
    data = response.get_data()
    operation_status = data["operations"][operation_to_id[operation]]["status"]
    return operation_status == "on"
except:
    return False
$$ LANGUAGE plpython3u;

------------------------------------------
-- TRIGGERS
------------------------------------------

-- WP_COMMENTS TRIGGERS
CREATE OR REPLACE FUNCTION latch_comments_check() RETURNS TRIGGER AS $$
def check_latch(operation):
    result = plpy.execute(plpy.prepare("SELECT check_latch($1) AS result", ["text"]), [operation])
    return result[0]["result"]

if check_latch("ReadOnly"):
    return
else:
    plpy.error('Latch protected')
$$ LANGUAGE plpython3u;

CREATE TRIGGER latch_comments_insert
BEFORE INSERT ON wp_comments
FOR EACH ROW EXECUTE FUNCTION latch_comments_check();

CREATE TRIGGER latch_comments_update
BEFORE UPDATE ON wp_comments
FOR EACH ROW EXECUTE FUNCTION latch_comments_check();

CREATE TRIGGER latch_comments_delete
BEFORE DELETE ON wp_comments
FOR EACH ROW EXECUTE FUNCTION latch_comments_check();

-- WP_POSTS TRIGGERS
CREATE OR REPLACE FUNCTION latch_posts_check() RETURNS TRIGGER AS $$
def check_latch(operation):
    result = plpy.execute(plpy.prepare("SELECT check_latch($1) AS result", ["text"]), [operation])
    return result[0]["result"]

if check_latch("ReadOnly") and check_latch("Edition"):
    return
else:
    plpy.error('Latch protected')
$$ LANGUAGE plpython3u;

CREATE TRIGGER latch_posts_insert
BEFORE INSERT ON wp_posts
FOR EACH ROW EXECUTE FUNCTION latch_posts_check();

CREATE TRIGGER latch_posts_update
BEFORE UPDATE ON wp_posts
FOR EACH ROW EXECUTE FUNCTION latch_posts_check();

CREATE TRIGGER latch_posts_delete
BEFORE DELETE ON wp_posts
FOR EACH ROW EXECUTE FUNCTION latch_posts_check();

-- WP_USERMETA TRIGGERS
CREATE OR REPLACE FUNCTION latch_usermeta_check() RETURNS TRIGGER AS $$
def check_latch(operation):
    result = plpy.execute(plpy.prepare("SELECT check_latch($1) AS result", ["text"]), [operation])
    return result[0]["result"]

if check_latch("ReadOnly") and (TD["new"]["meta_key"] == 'session_tokens' and check_latch("Administration")):
    return
else:
    plpy.error('Latch protected')
$$ LANGUAGE plpython3u;

CREATE TRIGGER latch_usermeta_insert
BEFORE INSERT ON wp_usermeta
FOR EACH ROW EXECUTE FUNCTION latch_usermeta_check();

CREATE TRIGGER latch_usermeta_update
BEFORE UPDATE ON wp_usermeta
FOR EACH ROW EXECUTE FUNCTION latch_usermeta_check();

CREATE TRIGGER latch_usermeta_delete
BEFORE DELETE ON wp_usermeta
FOR EACH ROW EXECUTE FUNCTION latch_usermeta_check();

-- WP_USERS TRIGGERS
CREATE OR REPLACE FUNCTION latch_users_check() RETURNS TRIGGER AS $$
def check_latch(operation):
    result = plpy.execute(plpy.prepare("SELECT check_latch($1) AS result", ["text"]), [operation])
    return result[0]["result"]

if check_latch("ReadOnly") and check_latch("Administration"):
    return
else:
    plpy.error('Latch protected')
$$ LANGUAGE plpython3u;

CREATE TRIGGER latch_users_insert
BEFORE INSERT ON wp_users
FOR EACH ROW EXECUTE FUNCTION latch_users_check();

CREATE TRIGGER latch_users_update
BEFORE UPDATE ON wp_users
FOR EACH ROW EXECUTE FUNCTION latch_users_check();

CREATE TRIGGER latch_users_delete
BEFORE DELETE ON wp_users
FOR EACH ROW EXECUTE FUNCTION latch_users_check();
