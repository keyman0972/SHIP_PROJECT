<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/pages/include/include.Taglib.jsp"%>
<html>
<head>
<title></title>
<s:include value="/WEB-INF/pages/include/include.Scripts.jsp" />
<script type="text/javascript" src="<s:url value="/jquery/ui/jquery.ui.datepicker.min.js"/>"></script>
<script type="text/javascript" src="<s:url value="/jquery/jquery.alphanumeric.js"/>"></script>
<script type="text/javascript" src="<s:url value="/ddscPlugin/ddsc.gridList.plugin.js"/>"></script>
<script type="text/javascript" src="<s:url value="/ddscPlugin/ddsc.popupWindow.plugin.js"/>"></script>	
<script type="text/javascript" src="<s:url value="/js/ddsc.input.js"/>"></script>
<script type="text/javascript">
function getParameter() {
	var param = "labOrderMst.orderId=" + $("#tblGrid").getSelectedRow().find('td').eq(3).text();
	return param;
}
$(document).ready(function() {
	$("#tblGrid").initGrid({lines:3});
	$('#tb').initPopupWindow({dailogWidth:'960', dailogHeight:'640'});
});
</script>
</head>
<body> 
<s:form id="frmSys03001K" theme="simple" action="%{progAction}" >
	<div class="progTitle">
  		<s:include value="/WEB-INF/pages/include/include.Title.jsp" />
	</div>
	<div id="tb">
		<fieldset id="listFieldset">
		<table width="100%" border="0" cellpadding="2" cellspacing="0">
			<tr class="trBgOdd">
				<td width="20%" class="colNameAlign required">*<s:text name="orderDate"/>：</td>
				<td width="30%"><s:textfield name="labOrderMst.orderDate" cssClass="enKey" maxlength="32" size="16" cssClass="inputDate" /></td>
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="orderId"/>：</td>
				<td width="30%"><s:textfield name="labOrderMst.orderId" maxlength="10" size="32"/></td>
			</tr>
			<tr class="trBgEven">
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="orderStatus"/>：</td>
				<td colspan = "3">
					<input type="checkbox" id="orderStatus0" name="orderStatusList[0]" value="0" <s:if test="orderStatusList[0] == \"0\"">checked</s:if> /><s:text name="orderStatus.0" />
					<input type="checkbox" id="orderStatus1" name="orderStatusList[1]" value="1" <s:if test="orderStatusList[1] == \"1\"">checked</s:if> /><s:text name="orderStatus.1" />
					<input type="checkbox" id="orderStatus2" name="orderStatusList[2]" value="2" <s:if test="orderStatusList[2] == \"2\"">checked</s:if> /><s:text name="orderStatus.2" />
					<input type="checkbox" id="orderStatus9" name="orderStatusList[9]" value="9" <s:if test="orderStatusList[9] == \"9\"">checked</s:if> /><s:text name="orderStatus.9" />
				</td>
			</tr>
			<tr class="trBgOdd">
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="custId"/>：</td>
				<td width="30%"><s:textfield name="labOrderMst.labCustMst.custId" maxlength="32" size="32" /></td>
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="custName"/>：</td>
				<td width="30%"><s:textfield name="labOrderMst.labCustMst.custName" maxlength="64" size="32"/></td>
			</tr>
		</table>
		<!-- 按鍵組合 --><s:include value="/WEB-INF/pages/include/include.ListButton.jsp" /><!-- 按鍵組合 --> 
		</fieldset>
		<table id="tblGrid" class ="labSuppMstList" width="100%" border="0" cellpadding="2" cellspacing="1">
			<thead>
				<tr align="center" bgcolor="#e3e3e3">
					<th width="3%"><s:text name="fix.00164" /></th>
					<th width="10%"><s:text name="fix.00090" /></th>
					<th width="17%"><s:text name="orderDate" /></th>   
					<th width="17%"><s:text name="orderId" /></th> 
					<th width="17%"><s:text name="custId" /></th>
					<th width="14%"><s:text name="shipDate" /></th>
					<th width="14%"><s:text name="orderAmt" /></th>
					<th><s:text name="orderStatus" /></th>	
				</tr>
			 </thead>
			 <tbody>
				 <s:iterator value="labOrderMstList" status="status">
				 	<tr>
						<td width="3%" id="sn" align="center"><s:property value="#status.index+1" /></td>
						<!-- 表單按鍵 --> 
						<td width="10%"><s:include value="/WEB-INF/pages/include/include.actionButton.jsp" /></td>
						<!-- 表單按鍵 -->
						<td width="17%" align="left"><label><s:property value="ORDER_DATE" /></label></td>
						<td width="17%" align="right"><label><s:property value="ORDER_ID" /></label></td>
						<td width="17%" align="center"><label><s:property value="CUST_ID" />&nbsp;<s:property value="CUST_NAME" /></label></td>	
						<td width="14%" align="center"><label><s:property value="SHIP_DATE" /></label></td>
						<td width="14%" align="right"><label><s:property value="ORDER_AMT" /></label></td>
						<td>
							<label>
								<s:if test="ORDER_STATUS ==\"0\""><s:property value="ORDER_STATUS" />-<s:text name="orderStatus.0"></s:text></s:if>
								<s:elseif test="ORDER_STATUS ==\"1\""><s:property value="ORDER_STATUS" />-<s:text name="orderStatus.1"></s:text></s:elseif>
								<s:elseif test="ORDER_STATUS ==\"2\""><s:property value="ORDER_STATUS" />-<s:text name="orderStatus.2"></s:text></s:elseif>
								<s:elseif test="ORDER_STATUS ==\"9\""><s:property value="ORDER_STATUS" />-<s:text name="orderStatus.9"></s:text></s:elseif>
							</label>
							</label>
						</td>
					</tr>
				 </s:iterator>
			 </tbody>
		</table>
	</div>
	<!-- 分頁按鍵列 --><s:include value="/WEB-INF/pages/include/include.PaginationBar.jsp" /><!-- 分頁按鍵列 -->
</s:form>
</body>
</html>