  <nav class="navbar navbar-inverse" role="navigation">
  <div class="container-fluid">
    <!-- Brand and toggle get grouped for better mobile display -->
    <div class="navbar-header">
      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="<?= base_url() ?>">车计划</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <li><a href="#">知识管理</a></li>        
        <?php
          nav_menu(array("服务管理","菜单管理","dishes","","订单管理","dorders")); 
          nav_menu(array("客户管理","客户管理","clients","车辆管理","cars","维修计划","plans","","预约管理","appointments","报价管理","prices"));
        ?> 

      </ul>
      <ul class="nav navbar-nav navbar-right">
         <?php if($userrole>=100) { 
                  nav_menu(array("系统管理","用户管理","users","店铺管理","shops",
                           "","任务类型","tasktypes","任务组管理","taskgroups",
                           "","车系管理","carseries","型号管理","carmodels",
                           "","字典管理","dics","系统设置","syssettings"));
                }
                
                nav_menu(array("当前用户:".$username,"用户设置","usersettings","通知信息","notifys","","注销","logout"));
          ?>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
  </nav>