<!-- Split button -->
<div class="btn-group">
  <button type="button" class="btn btn-default btn-sm"><?php echo $title ?></button>
  <button type="button" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown">
    <span class="caret"></span>
    <span class="sr-only">Toggle Dropdown</span>
  </button>
  <ul class="dropdown-menu" role="menu">
    <?php
      foreach($list as $item) {
        if ($item["mtype"]==0) { // link
          echo "<li><a href='".$item["mlink"]."'>".$item["mtitle"]."</a></li>";          
        } else if ($item["mtype"]==1) { //js
          
        } else { //分隔符
          echo "<li class='divider'></li>";
        }
      }
    
    ?>
  </ul>
</div>