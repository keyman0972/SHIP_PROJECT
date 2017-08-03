<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/include/include.Taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<base target="_self" />
<s:include value="/WEB-INF/pages/include/include.Scripts.jsp" />
<script type="text/javascript" src="<s:url value="/ddscPlugin/ddsc.gridEditList.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/ddscPlugin/ddsc.validation.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/jquery.alphanumeric.js"/>"></script>
<script type="text/javascript" src="<s:url value="/js/ddsc.input.js"/>"></script>
<script language="javascript">
var oTable;
//畫面欄位檢核
function validate() {
	$("#frmSys03001K").validate("clearPrompt"); 
	
	if($(":checked").val() == "9"){
		$("#OrderNote").validateRequired({fieldText:'<s:text name="orderNote" />'});
	}
	
	alert(!$("#frmSys03001K").validate("isErrors"));
	if(!$("#frmSys03001K").validate("isErrors")){
		fnSetOperate(oTable);
	}
    return $("#frmSys03001K").validate("showPromptWithErrors");
}
$(document).ready(function(){
	oTable = $('#tblGrid').initEditGrid({height:'250'});
	
	if($("#orderStatus").val() =="0"){
		
		$(".StatusRadio1").hide();
		$(".StatusLabel1").hide();
		
	}else if($("#orderStatus").val() =="1"){
		
		$(".StatusRadio0").hide();
		$(".StatusLabel0").hide();
		
	}
	
	if($("#orderStatus").val() == "2" || $("#orderStatus").val() == "9"){
		$(".StatusRadio0").prop("disabled",true);
		$(".StatusRadio1").prop("disabled",true);
		$(".orderNote").prop("disabled",true);
		$("#btnSmt").hide();
	}
});

</script>
</head>
<body>
<s:form id="frmSys03001K" method="post" theme="simple" action="%{progAction}" target="ifrConfirm">
<s:hidden name="labOrderMst.ver" />
 	<div class="progTitle"> 
		<s:include value="/WEB-INF/pages/include/include.EditTitle.jsp" />
    </div>
    <div id="tb">
    <table width="100%" border="0" cellpadding="4" cellspacing="0" >
			<tr class="trBgOdd">
				<td width="20%" class="colNameAlign required">*<s:text name="orderDate" />：</td>
				<td width="30%">
					<s:property value="labOrderMst.orderDate" />
					<s:hidden name="labOrderMst.orderDate"/>
					<s:hidden name="labOrderMst.shipDate"/>
				</td>
				<td width="20%" class="colNameAlign required">*<s:text name="orderId" />：</td>
				<td width="30%">
					<s:property value="labOrderMst.orderId" />
					<s:hidden name="labOrderMst.orderId"/>
				</td>
			</tr>
			<tr class="trBgEven">
				<td width="20%" class="colNameAlign required">*<s:text name="custId" />：</td>
				<td width="30%">
					<s:property value="labOrderMst.labCustMst.custId"/>&nbsp;
					<s:property value="labOrderMst.labCustMst.custName"/>
					<s:hidden name="labOrderMst.labCustMst.custId" value="%{labOrderMst.labCustMst.custId}"/>
					<s:hidden name="labOrderMst.labCustMst.custName" value="%{labOrderMst.labCustMst.custName}"/>
				</td>
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="orderAmt" />：</td>
				<td width="30%">
					<s:property value="labOrderMst.orderAmt"/>
					<s:hidden id="hidden_orderAmt" name="labOrderMst.orderAmt" value="%{labOrderMst.orderAmt}" />
				</td>
			</tr>
			<tr class="trBgOdd">
				<td width="20%" class="colNameAlign required">*<s:text name="orderStatus" />：</td>
				<td coslpan = "3">
					<span>
						<input type="radio" id="orderstatus1" name="labOrderMst.orderStatus" value="1" class="StatusRadio0" <s:if test="labOrderMst.orderStatus == \"1\"">checked</s:if> />
						<s:label for="orderstatus1" cssClass="StatusLabel0" value="%{getText(\"orderStatus.1\")}"/>
						<input type="radio" id="orderstatus2" name="labOrderMst.orderStatus" value="2" class="StatusRadio1" <s:if test="labOrderMst.orderStatus == \"2\"">checked</s:if> />
						<s:label for="orderstatus2" cssClass="StatusLabel1" value="%{getText(\"orderStatus.2\")}"/>
						<input type="radio" id="orderstatus9" name="labOrderMst.orderStatus" value="9" class="StatusRadio0" <s:if test="labOrderMst.orderStatus == \"9\"">checked</s:if> />
						<s:label for="orderstatus9" cssClass="StatusLabel0" value="%{getText(\"orderStatus.9\")}"/>
						<s:hidden id="orderStatus" value="%{labOrderMst.orderStatus}" />
					</span>
				</td>
			</tr>
			<tr class="trBgEven">
				<td width="20%" class="colNameAlign required">*<s:text name="orderNote" />：</td>
				<td class="orderNote" coslpan = "3">
					<s:textarea id="OrderNote" rows="4" cols="90"></s:textarea>
				</td>
			</tr>
	</table>
    <fieldset style="-moz-border-radius:4px;">
    <table id="tblGrid" width="100%" border="0" cellpadding="2" cellspacing="1">
        <thead>
            <tr align="center" bgcolor="#e3e3e3">
                <th width="30"><s:text name="fix.00164" /></th>
                <th width="40%"><s:text name="itemId" /></th>
                <th width="20%"><s:text name="itemPrice" /></th>
                <th width="15%"><s:text name="orderQty" /></th>
                <th><s:text name="subTotal" /></th>
                <th style="display: none;">&nbsp;</th>          
            </tr>
        </thead>
		<tbody id="tbGrid">
	        <s:iterator value="labOrderMst.labOrderItemList" status="stat">
	        <tr>
	            <td id="SN" align="center" align="center" width="30">
	            	<s:property value="#stat.index + 1" />
	            </td>
	            <td width="40%">
	                <s:label id="%{'itemId_' + #stat.index}" name="%{'labOrderMst.labOrderItemList['+#stat.index+'].labItemMst.itemId'}" value="%{labOrderMst.labOrderItemList[#stat.index].labItemMst.itemId}" />
	            	<s:hidden id="%{'hidden_itemId_' + #stat.index}" name="%{'labOrderMst.labOrderItemList['+#stat.index+'].labItemMst.itemId'}" />
	            </td>
	            <td width="20%" align="right">
	            	<s:label id="%{'itemPrice_' + #stat.index}" name="%{'labOrderMst.labOrderItemList['+#stat.index+'].labItemMst.itemPrice'}" value="%{labOrderMst.labOrderItemList[#stat.index].labItemMst.itemPrice}" />
	            	<s:hidden id="%{'hidden_orderPrice_' + #stat.index}" name="%{'labOrderMst.labOrderItemList['+#stat.index+'].labItemMst.itemPrice'}" />
	            </td>
	            <td width="15%" align="right">
	            	<s:label id="%{'orderQty_' + #stat.index}" name="%{'labOrderMst.labOrderItemList['+#stat.index+'].orderQty'}" value="%{labOrderMst.labOrderItemList[#stat.index].orderQty}" />
	            	<s:hidden id="%{'hidden_orderQty_' + #stat.index}" name="%{'labOrderMst.labOrderItemList['+#stat.index+'].orderQty'}" />
	            </td>
	            <td align="right">
	            	<s:label id="%{'subTotal_' + #stat.index}" name="%{'labOrderMst.labOrderItemList['+#stat.index+'].subTotal'}" value="%{labOrderMst.labOrderItemList[#stat.index].subTotal}" />
	            	<s:hidden id="%{'hidden_subTotal_' + #stat.index}" name="%{'labOrderMst.labOrderItemList['+#stat.index+'].subTotal'}" />
	            </td>
	            <td style="display: none;">
	            	<s:hidden id="%{'ver_' + #stat.index}" name="%{'labOrderMst.labOrderItemList['+#stat.index+'].ver'}"/>
	                <s:hidden id="%{'orderItemOid_' + #stat.index}" name="%{'labOrderMst.labOrderItemList['+#stat.index+'].orderItemOid'}" />
	            </td>
	        </tr>
	        </s:iterator>   
		</tbody>
    </table>
    </fieldset>
    </div>
	<!-- 按鍵組合 --> 
<%-- 	<s:if test="labOrderMst.orderStatus == \"2\" || labOrderMst.orderStatus == \"9\""> --%>
<%-- 		<s:include value="/WEB-INF/pages/include/include.ShowButton.jsp" />  --%>
<%-- 	</s:if> --%>
<%-- 	<s:elseif test="labOrderMst.orderStatus == \"0\" || labOrderMst.orderStatus == \"1\""> --%>
		<s:include value="/WEB-INF/pages/include/include.EditButton.jsp" />
<%-- 	</s:elseif> --%>
	<!-- 按鍵組合 -->
</s:form>
<iframe id="ifrConfirm" name="ifrConfirm" width="100%" height="768" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="display:none; border: 0px none"></iframe>
</body>
</html>