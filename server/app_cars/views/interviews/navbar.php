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
      <a class="navbar-brand" href="<?= base_url() ?>">面试测试</a>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
      <ul class="nav navbar-nav">
        <?php
          if ($userrole>0) {
            nav_menu(array("测试操作","主目录","sclasses","结果和反馈","smembers")); 
          }
        ?> 

      </ul>

      <ul class="nav navbar-nav navbar-right">
         <?php if($userrole>100) { 
                  nav_menu(array("系统管理","列表","users","店铺管理","shops",
                           "","任务类型","tasktypes","任务组管理","taskgroups",
                           "","车系管理","carseries","型号管理","carmodels",
                           "","字典管理","dics","系统设置","settings"));
                } else if ($userrole>=10) {
                  echo "<li class='dropdown'><a><div id='timer'></div></a></li>";
                  nav_menu(array("当前用户:".$username,"用户设置","usersettings","通知信息","notifys","","注销","logout"));
                }
          ?>
      </ul>
    </div><!-- /.navbar-collapse -->
  </div><!-- /.container-fluid -->
  </nav>

<?php if ($userrole==10) { ?>  
<script>  
  function timer(time,update,complete) {
    var start = new Date().getTime();
    var interval = setInterval(function() {
        var now = time-(new Date().getTime()-start);
        if( now <= 0) {
            clearInterval(interval);
            complete();
        }
        else update(Math.floor(now/1000));
    },100); // the smaller this number, the more accurate the timer will be
  }
  
  timer(
    600000, // milliseconds
    function(timeleft) { // called every step to update the visible countdown
        document.getElementById('timer').innerHTML = "剩余时间: "+ Math.round(timeleft/60)+" 分";
    },
    function() { // what to do after
        alert("时间到!!");
    }
  );

</script>

<?php } ?>
  
  