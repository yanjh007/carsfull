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
        <li><a href="#">服务管理</a></li>
        <li><a href="#">知识管理</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown">客户管理 <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu">
            <?php
              nav_menu_item("客户管理","clients");
              nav_menu_item("车辆管理","cars");
              nav_menu_item("维修计划","plans");
              nav_menu_item("","");
              nav_menu_item("预约管理","appointments");
              nav_menu_item("报价管理","");
            ?>
          </ul>
        </li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
         <?php if($userrole>=100) { ?>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">系统管理<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                <?php
                  nav_menu_item("用户管理","users");
                  nav_menu_item("店铺管理","shops");
    
                  nav_menu_item("","");
                  nav_menu_item("任务类型","tasktypes");
                  nav_menu_item("任务组管理","taskgroups");
    
                  nav_menu_item("","");
                  nav_menu_item("车系管理","carseries");
                  nav_menu_item("型号管理","carmodels");
    
                  nav_menu_item("","");
                  nav_menu_item("字典管理","dics");
                  nav_menu_item("系统设置","syssettings");
                ?>
                </ul>
            </li>
         <?php } ?>
         <li class="dropdown">
             <a href="#" class="dropdown-toggle" data-toggle="dropdown">当前用户: <?php echo $username ?> <span class="caret"></span></a>
             <ul class="dropdown-menu" role="menu">
              <?php
                  nav_menu_item("用户设置","usersettings");
                  nav_menu_item("通知信息","notifys");
                  nav_menu_item("","");
                  nav_menu_item("注销","logout");
              ?>
             </ul>
         </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
  </nav>