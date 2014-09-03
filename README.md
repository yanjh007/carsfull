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

# 20140821
- full project manager, include server side, client(iOS) init project
- document for structure and technical path
- cars and carmodels improve-
- carmodels module
- iOS client app begin, base page: menu, home, login

# 20140822
- iOS client network function add
- common service interface and crypt research
- delete button improved
- zm_form_open and zm_form_hidden improved

# 20140825
- client bind module, login, verify code, iOS client and CI server side
- iOS app menu icon
- service interface update, general json template and useage
- codeigniter unit test update, common test all method


# 20140826
- iOS app client login update and optimize
- iOS app FMDatabase integrate, dbhelper, dbinit, dbupdate
- car model and VC begin, section info
- client service, recover code verify and password reset(client model)


# 20140827
- iOS app client appointment module,list-detail, model,viewcontroller and connect with cars module
- iOS database improved
- Helper improved
- model file merged

# 20140901
- iOS app client appointment module
- server side, login module, add session and session check function

# 20140902
- iOS App, shop module, vc, data sync
- iOS App, left menu use tableview
- server side, appointment and shop interface, login interface improved
- server side version, version control, zmversion model
- iOS App, metadata improve, support shop version, db init before view
- database improved

# 20140903
- appointment workflow implementing
- 










