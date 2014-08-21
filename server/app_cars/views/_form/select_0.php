<div class="form-group">
  <label class="col-sm-1 control-label"><?= $title ?></label>
  <div class="col-sm-6">
    <select class="form-control" name="<?=$name ?>" id="<?=$name ?>">
      <?php for ($i=0;$i < count($list);$i++): $kv= explode(":",$list[$i]); ?>
        <option value="<?= $kv[0] ?>" <?php if ($select==$kv[0]) echo "selected";?> >
          <?= $kv[1] ?>
        </option>
      <?php endfor ?>
    </select>
  </div>
</div>
