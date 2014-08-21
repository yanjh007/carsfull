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
            <li><a href="<?= base_url("clients") ?>">客户管理</a></li>
            <li><a href="<?= base_url("cars") ?>">车辆管理</a></li>
            <li><a href="<?= base_url("plans") ?>">维护计划</a></li>
            <li class="divider"></li>
            <li><?= anchor(base_url("appointments"),"预约管理") ?></li>
            <li><a href="prices">报价管理</a></li>
          </ul>
        </li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
         <?php if($userrole>=100) { ?>
            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">系统管理<span class="caret"></span></a>
                <ul class="dropdown-menu" role="menu">
                  <li><?= anchor(base_url("users"),"用户管理") ?>
                  <li><?= anchor(base_url("shops"),"店铺管理") ?></li>
                  <li class="divider"></li>
                  <li><?= anchor(base_url("tasktypes"),"任务类型") ?></li>
                  <li><?= anchor(base_url("taskgroups"),"任务组管理") ?></li>
                  <li class="divider"></li>
                  <li><?= anchor(base_url("carmodels"),"型号管理") ?></li>
                  <li class="divider"></li>
                  <li><?= anchor(base_url("dics"),"字典管理") ?></li>
                  <li><?= anchor(base_url("syssettings"),"系统设置") ?></li>
                </ul>
            </li>
         <?php } ?>
         <li class="dropdown">
             <a href="#" class="dropdown-toggle" data-toggle="dropdown">当前用户: <?php echo $username ?> <span class="caret"></span></a>
             <ul class="dropdown-menu" role="menu">
               <li><?= anchor(base_url("usersettings"),"用户设置") ?></li>
               <li><a href="#">通知</a></li>
               <li class="divider"></li>
               <li><a href="logout">注销</a></li>
             </ul>
         </li>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
  </nav>