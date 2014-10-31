<div class="form-group">
<?php if ($ftype==0) { ?>
  <label class="col-sm-1 control-label"><?php echo  $title ?></label>
  <div class="col-sm-6">
  <input class="form-control" type="<?php echo $itype ?>" id="<?php echo $name ?>" name="<?php echo $name ?>" value="<?php echo $value ?>" >
  </div>
<?php } elseif($ftype==1) { ?>
  <label ><?php echo  $title ?></label>
  <input class="form-control" type="<?php echo $itype ?>" id="<?php echo $name ?>" name="<?php echo $name ?>" value="<?php echo $value ?>" >
<?php } ?>
</div>
