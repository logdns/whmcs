{php}$SUBID=$this->_tpl_vars['server_details']['SUBID'];{/php}
<h3>Information:</h3>
<div class="col2half">
    <p></p><h4>IPv4:</h4> <span>{php}echo $this->_tpl_vars['server_details']['main_ip'];{/php}</span><p></p>
</div>
<div class="col2half">
    <p></p><h4>IPv6:</h4> <span>
    {php}
        if(!empty($this->_tpl_vars['server_details']['v6_main_ip'])){
            echo $this->_tpl_vars['server_details']['v6_main_ip'];
        } else {
            echo 'not available';
        }
    {/php}
     </span><p></p>
</div>
<div class="col2half">
    <p></p><h4>Default Password:</h4> <span>{php}echo $this->_tpl_vars['server_details']['default_password'];{/php}</span><p></p>
</div>
<div class="col2half">
    <p></p><h4>Bandwidth Used:</h4> <span>{php}echo $this->_tpl_vars['server_details']['current_bandwidth_gb'].'GB/'.$this->_tpl_vars['server_details']['allowed_bandwidth_gb'].'GB';{/php}</span><p></p>
</div>
<div class="col2half">
    <p></p><h4>Server Status:</h4> <span>{php}echo $this->_tpl_vars['server_details']['status'];{/php}</span><p></p>
</div>
<div class="col2half">
    <p></p><h4>Power Status:</h4> <span>{php}echo $this->_tpl_vars['server_details']['power_status'];{/php}</span><p></p>
</div>
<h3>Control:</h3>
<div align="center">
  <table border="0" cellpadding="0" cellspacing="0">
    <tbody>
      <tr>
        <td style="width:67px;text-align:center;vertical-align:top;"><form method="post" action="clientarea.php?action=productdetails">
            <div style="margin:10px;" align="center">
              <div style="text-align:center;width:62px;">
                <input type="hidden" name="id" value="{php}echo $this->_tpl_vars['id'];{/php}">
                <input type="hidden" name="modop" value="custom">
                <input type="hidden" name="a" value="reboot">
                <input style="height:50px;" type="image" src="./modules/servers/vultr/img/reboot.png" alt="Reboot">
              </div>
              重启 </div>
          </form></td>
        <td style="width:67px;text-align:center;vertical-align:top;"><form method="post" action="clientarea.php?action=productdetails">
            <div style="margin:10px;" align="center">
              <div style="text-align:center;width:62px;">
                <input type="hidden" name="id" value="{php}echo $this->_tpl_vars['id'];{/php}">
                <input type="hidden" name="modop" value="custom">
                <input type="hidden" name="a" value="start">
                <input style="height:50px;" type="image" src="./modules/servers/vultr/img/poweron.png" alt="Power On">
              </div>
              开机 </div>
          </form></td>
        <td style="width:67px;text-align:center;vertical-align:top;"><form method="post" action="clientarea.php?action=productdetails">
            <div style="margin:10px;" align="center">
              <div style="text-align:center;width:62px;">
                <input type="hidden" name="id" value="{php}echo $this->_tpl_vars['id'];{/php}">
                <input type="hidden" name="modop" value="custom">
                <input type="hidden" name="a" value="halt">
                <input style="height:50px;" type="image" src="./modules/servers/vultr/img/poweroff.png" alt="Power Off">
              </div>
              关机 </div>
          </form></td>
        <td style="width:67px;text-align:center;vertical-align:top;"><form method="post" action="clientarea.php?action=productdetails">
            <div style="margin:10px;" align="center">
              <div style="text-align:center;width:62px;">
                <input type="hidden" name="id" value="{php}echo $this->_tpl_vars['id'];{/php}">
                <input type="hidden" name="modop" value="custom">
                <input type="hidden" name="a" value="reinstall">
                <input style="height:50px;" type="image" src="./modules/servers/vultr/img/reinstall.png" alt="Reinstall">
              </div>
              重装系统 </div>
          </form></td>
        <td style="width:67px;text-align:center;vertical-align:top;">
            <div style="margin:10px;" align="center">
              <div style="text-align:center;width:50px;">
    		<A style="height:50px;"  href="{php}echo str_replace("my.vultr.com","64.237.53.37",$this->_tpl_vars['server_details']['kvm_url']);{/php}" target="_blank">
                <img src="./modules/servers/vultr/img/vnc.png" alt="VNC"></a>
              </div>
              VNC</div>
          </td>
      </tr>
    </tbody>
  </table>
</div>
