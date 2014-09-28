<div class="form-group">
  <?php if($ftype==0): ?>
    <label class="col-sm-1 control-label"><?php echo $title ?></label>
    <div class="col-sm-6">
      <select class="form-control" name="<?php echo $name ?>" id="<?php echo $name ?>">
        <?php foreach  ($list as $k=>$v): ?>
          <option value="<?php echo $k;?>"
            <?php echo ($k==$select?" selected>":">").$v; ?>
          </option>
        <?php endforeach ?>
      </select>
    </div>
  <?php else: ?>
    <label ><?php echo $title ?></label>
      <select class="form-control" name="<?php echo $name ?>" id="<?php echo $name ?>">
        <?php foreach  ($list as $k=>$v): ?>
          <option value="<?php echo $k;?>"
            <?php echo ($k==$select?" selected>":">").$v; ?>
          </option>
        <?php endforeach ?>
      </select>  
  <?php endif ?>
</div>

