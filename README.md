cars
====

what i worked

Config tips:
1. assets 
need copy to website root, include boottrap3.1,css,img,fonts,js(jquery1.11.1,js sha1 use for auth)

2. system 
codeigniter system,version 2.3.2

3. application


4. cidb.sql
database structure and some data, export sql

5. url rewrite config
ngnix.conf:
location /capp2 {
            index index.php;
            rewrite ^/capp2/(.*)+$ /capp2/index.php?$1; # it finally works
            # return 200 $request_uri; # it is for inspect what $request_uri is
            # try_files $uri $uri/ /blog/index.php$request_uri$is_args$args; # it gets 500 server error
}

apache:
.htaccess, see misc/htsample file 


-------------------------------------------------------------------------
dev journal
# before 20140812
-- chose SAE as cloud plateform
-- php-mysql as application backbone
-- codeigniter as application framework
-- bootstrap as front framework
-- komode edit as dev tools
-- application enveronment, database, rewrite config
-- sample page and component
-- login,logout and session controll help
-- auth security, client sha1 submit, server sha1 password save
-- some database structure
-- client module dev in process

# 20140812
-use github as source controll system, sourcetree as client
-transfer from xampp to nginx+php+mysql, data export and import test(it's OK)
-fix bug of transfer:
--header aready sent(user model file has a space before <?php)
--session uninitaled,use session_destroy after unset_userdata, once is enough


# 20140813
- service interface
- appclient login and verify service, database zmsession structure

# 20140814
- client module form, and workflow
- js,jquery and ajax integrate

# 20140815
- cars modle,table,base view, routes
- links table
- clients and cars link, client side
- dic table, dic list view

# 20140818
- general link model, link and unlink method
- shop module update
- tasktype and taskgroup module, db, m-m relation implement
- route improve, wild match, no need define route for eatch resource
- user module improvced

# 20140819
- dubug log open
- taskgroup and tasktyps reloation in table
- improve view for form(_form folder subviews), zmform helper
- delete dialog(bootstrap div) 
- link model update

# 20140820
- appointment module begin, 
- user module updated, user modify, shop select, shop table join
- form improve, select, radio template
- 






