<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/pages/include/include.Taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<base target="_self" />
<s:include value="/WEB-INF/pages/include/include.Scripts.jsp" />
<script type="text/javascript" src="<s:url value="/ddscPlugin/ddsc.gridList.plugin.js"/>"></script>
<script language="javascript">
$(document).ready(function() {
    $("#tblGrid").initGrid({height:'480'});   
});
</script>
</head>
<body>
<s:form method="post" theme="simple" action="%{progAction}">
	<s:hidden name="labOrderMst.ver" />
	<div class="progTitle"> 
       <!-- 程式標題 --> <s:include value="/WEB-INF/pages/include/include.ShowTitle.jsp" /> <!-- 程式標題 -->
	</div>
    <div id="tb">
	<table width="100%" border="0" cellpadding="4" cellspacing="0" >
	<tbody>
    </tbody>
    </table>
    <fieldset style="-moz-border-radius:4px;">
    <table width="100%" border="0" cellpadding="2" cellspacing="0">
			<tr class="trBgOdd">
				<td width="20%" class="colNameAlign required">*<s:text name="orderDate"/>：</td>
				<td width="30%">
					<s:property value="labOrderMst.orderDate" />
					<s:hidden name="labOrderMst.orderDate"/>
				</td>
				<td width="20%" class="colNameAlign required">*<s:text name="orderId"/>：</td>
				<td width="30%">
					<s:property value="labOrderMst.orderId" />
					<s:hidden name="labOrderMst.orderId"/>
					<s:hidden name="labOrderMst.orderStatus" />
				</td>
			</tr>
			<tr class="trBgEven">
				<td width="20%" class="colNameAlign required">*<s:text name="custId" />：</td>
				<td width="30%">
					<s:property value="labOrderMst.labCustMst.custId"/>&nbsp;<s:property value="labOrderMst.labCustMst.custName"/>
				</td>
				<td width="20%" class="colNameAlign">&nbsp;<s:text name="orderAmt" />：</td>
				<td width="30%">
					<s:property value="labOrderMst.orderAmt" />
					<s:hidden id="hidden_orderAmt" name="labOrderMst.orderAmt" value="%{labOrderMst.orderAmt}" />
				</td>
			</tr>
			<tr class="trBgOdd">
				<td width="20%" class="colNameAlign required">*<s:text name="orderStatus" />：</td>
				<td width="30%">
					<s:if test="labOrderMst.orderStatus == \"0\""><s:text name="orderStatus.0" /></s:if>
					<s:elseif test="labOrderMst.orderStatus == \"1\""><s:text name="orderStatus.1" /></s:elseif>
					<s:elseif test="labOrderMst.orderStatus == \"2\""><s:text name="orderStatus.2" /></s:elseif>
					<s:elseif test="labOrderMst.orderStatus == \"9\""><s:text name="orderStatus.9" /></s:elseif>
				</td>
			</tr>
			<tr class="trBgEven">
				<td width="20%" class="colNameAlign required">*<s:text name="orderNote" />：</td>
				<td colspan="3">
					<s:property value="labOrderMst.orderNote" />
				</td>
			</tr>
		</table>
    <table id="tblGrid" width="100%" border="0" cellpadding="2" cellspacing="1">
        <thead>
            <tr align="center" bgcolor="#e3e3e3">
                <th width="30"><s:text name="fix.00164" /></th>
                <th width="40%"><s:text name="itemId" /></th>
                <th width="20%"><s:text name="orderPrice" /></th>
                <th width="15%"><s:text name="orderQty" /></th>
                <th><s:text name="subTotal" /></th>   
            </tr>
        </thead>
		<tbody id="tbGrid">
		<s:iterator value="labOrderMst.labOrderItemList" status="stat">
            <tr>
                <td id="SN" align="center" width="30"><s:property value="#stat.index + 1" /></td>
             	<td width="40%" align="left">
                	<label>
                		<s:property value="labItemMst.itemId"/>&nbsp;-&nbsp;
                		<s:property value="labItemMst.itemName"/>
               		</label>
           		</td>
	            <td width="20%" align="right">
		            <label>
                		<s:property value="orderPrice"/>
               		</label>
	            </td>
	            <td width="15%" align="right">
		            <label>
                		<s:property value="orderQty"/>
               		</label>
	            </td>
	            <td align="right">
		            <label>
                		<s:property value="subTotal"/>
               		</label>
	            </td>
	            <td style="display: none;"></td>
            </tr>
        </s:iterator>
    	</tbody>
    </table>
    </fieldset>
    </div>
    <!-- 按鍵組合 --> 
        <s:include value="/WEB-INF/pages/include/include.ShowButton.jsp" /> 
    <!-- 按鍵組合 -->
</s:form>
</body>
</html>