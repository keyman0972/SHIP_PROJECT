package com.ddsc.km.lab.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ddsc.core.action.AbstractAction;
import com.ddsc.core.action.IBaseAction;
import com.ddsc.core.exception.DdscApplicationException;
import com.ddsc.core.exception.DdscAuthException;
import com.ddsc.core.util.Pager;
import com.ddsc.km.lab.entity.LabOrderMst;
import com.ddsc.km.lab.service.ILabCustMstService;
import com.ddsc.km.lab.service.ILabOrderMstService;

/**
 * <table>
 * <tr>
 * <th>版本</th>
 * <th>日期</th>
 * <th>詳細說明</th>
 * <th>modifier</th>
 * </tr>
 * <tr>
 * <td>1.0</td>
 * <td>2017/7/12</td>
 * <td>新建檔案</td>
 * <td>"keyman"</td>
 * </tr>
 * </table>
 * @author "keyman"
 *
 * 類別說明 :
 *
 *
 * 版權所有 Copyright 2008 © 中菲電腦股份有限公司 本網站內容享有著作權，禁止侵害，違者必究。 <br>
 * (C) Copyright Dimerco Data System Corporation Inc., Ltd. 2009 All Rights
 */

public class Lab03001KAction extends AbstractAction implements IBaseAction {

	private static final long serialVersionUID = -683430135950590245L;
	
	private ILabOrderMstService labOrderMstService;
	private List<LabOrderMst> labOrderMstList;
	private LabOrderMst labOrderMst;
	
	private List<String> orderStatusList;
	private ILabCustMstService labCustMstService;
	
	@Override
	public String init() throws Exception {
		try {
		} 
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()),e.getMsgFullMessage() }));
		}
		setNextAction(ACTION_SEARCH);
		return SUCCESS;
	}
	
	@Deprecated
	@Override
	public String create() throws Exception {
		return null;
	}
	@Deprecated
	@Override
	public String createSubmit() throws Exception {

		return null;

	}
	@Deprecated
	@Override
	public String createConfirm() throws Exception {
		return null;
	}

	@Override
	public String update() throws Exception {
		try {
			//依條件取得要修改的資料
			labOrderMst = this.getLabOrderMstService().get(labOrderMst.getOrderId(), this.getUserInfo());
			
		}
		catch (DdscApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		setNextAction(ACTION_UPDATE_SUBMIT);
		return SUCCESS;
	}

	@Override
	public String updateSubmit() throws Exception {
		try {
			if (hasConfirm()) {
				setNextAction(ACTION_UPDATE_CONFIRM);
				return RESULT_CONFIRM;
			}else {
				return this.updateConfirm();
			}
		}catch (DdscApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
			setNextAction(ACTION_UPDATE_SUBMIT);
			return RESULT_EDIT;
		}catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
			setNextAction(ACTION_UPDATE_SUBMIT);
			return RESULT_EDIT;
		}
	}

	@Override
	public String updateConfirm() throws Exception {
		try {
			// 呼叫 Service 修改資料
			labOrderMst = this.getLabOrderMstService().update(labOrderMst, this.getUserInfo());
			setNextAction(ACTION_UPDATE);
			return RESULT_SHOW;
		}
		catch (DdscApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
			setNextAction(ACTION_UPDATE_SUBMIT);
			return RESULT_EDIT;
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
			setNextAction(ACTION_UPDATE_SUBMIT);
			return RESULT_EDIT;
		}
	}
	
	@Deprecated
	@Override
	public String delete() throws Exception {
		return null;
	}
	
	@Deprecated
	@Override
	public String deleteConfirm() throws Exception {
		return null;
	}

	@Override
	@SuppressWarnings("unchecked")
	public String search() throws Exception {
		try {
			Map<String, Object> conditions = new HashMap<String, Object>();
			conditions.put("orderDate", labOrderMst.getOrderDate());
			conditions.put("orderId", labOrderMst.getOrderId());
			conditions.put("orderStatus", orderStatusList);
			conditions.put("labCustMst.custId", labOrderMst.getLabCustMst().getCustId());
			conditions.put("labCustMst.custName", labOrderMst.getLabCustMst().getCustName());
			Pager resultPager = getLabOrderMstService().searchByConditions(conditions, getPager(), this.getUserInfo());
			labOrderMstList = (List<LabOrderMst>) resultPager.getData();
			this.setLabOrderMstList(labOrderMstList);
			setPager(resultPager);
			if (labOrderMstList == null || labOrderMstList.size() <= 0) {
				this.addActionError(this.getText("w.0001"));
			}
		} catch (DdscApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()),e.getMsgFullMessage() }));
		} catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()),e.getMsgFullMessage() }));
		}
		setNextAction(ACTION_SEARCH);
		return SUCCESS;
	}
	
	@Override
	public String query() throws Exception {
		try{
			labOrderMst = getLabOrderMstService().get(labOrderMst.getOrderId(), this.getUserInfo());		
		} catch (DdscApplicationException e) {
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()),e.getMsgFullMessage() }));
		} catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()),e.getMsgFullMessage() }));
		}
		setNextAction(ACTION_QUERY);
		return SUCCESS;
	}
	
	
	@Override
	public void validate() {
		try {
			setUpInfo();
		}
		catch (DdscAuthException e) {
			throw e;
		}
		catch (DdscApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] { e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage() }));
		}
	}

	/**
	 * 檢核 - 按送出鈕(新增頁)
	 */
	public void validateCreateSubmit() {
		try {
			this.checkPrimaryKey();
			this.checkValidateRule();
		}
		catch (DdscAuthException e) {
			throw e;
		}
		catch (DdscApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
	}

	/**
	 * 檢核 - 按確定鈕(新增頁)
	 */
	public void validateCreateConfirm() {
		// 先執行Action所對應的 validate, 再執行 validate(). (即 validateCreateSubmit 執行完後, 再執行 validate())
		try {
			this.checkPrimaryKey();
			this.checkValidateRule();
		}
		catch (DdscAuthException e) {
			throw e;
		}
		catch (DdscApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
	}

	/**
	 * 檢核 - 按送出鈕(修改頁)
	 */
	public void validateUpdateSubmit() {
		try {
			this.checkValidateRule();
		}
		catch (DdscAuthException e) {
			throw e;
		}
		catch (DdscApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
	}

	/**
	 * 檢核 - 按確定鈕(修改頁)
	 */
	public void validateUpdateConfirm() {
		// 先執行Action所對應的 validate, 再執行 validate(). (即 validateUpdateConfirm 執行完後, 再執行 validate())
		try {
			this.checkValidateRule();
		}
		catch (DdscAuthException e) {
			throw e;
		}
		catch (DdscApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
	}

	/**
	 * 檢核 - 按確定鈕(刪除頁)
	 */
	public void validateDeleteConfirm() {
		// 先執行Action所對應的 validate, 再執行 validate(). (即 validateDeleteConfirm 執行完後, 再執行 validate())
		try {
			this.checkValidateRule();
		}
		catch (DdscAuthException e) {
			throw e;
		}
		catch (DdscApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
	}

	/**
	 * 檢核 - 按送出鈕(複製頁)
	 */
	public void validateCopySubmit() {
		// 先執行Action所對應的 validate, 再執行 validate(). (即 validateCreateSubmit 執行完後, 再執行 validate())
		try {
			this.checkPrimaryKey();
			this.checkValidateRule();
		}
		catch (DdscAuthException e) {
			throw e;
		}
		catch (DdscApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
	}

	/**
	 * 檢核 - 按確定鈕(複製頁)
	 */
	public void validateCopyConfirm() {
		// 先執行Action所對應的 validate, 再執行 validate(). (即 validateCreateSubmit 執行完後, 再執行 validate())
		try {
			this.checkPrimaryKey();
			this.checkValidateRule();
		}
		catch (DdscAuthException e) {
			throw e;
		}
		catch (DdscApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
	}

	/**
	 * 檢核ID是否重複
	 * 
	 * @return
	 * @throws Exception
	 */
	private boolean checkPrimaryKey() throws Exception {
		boolean isValid = true;
		
		Map<String, Object> conditions = new HashMap<String, Object>();
		
		conditions.put("orderId", labOrderMst.getOrderId());
		
		if (labOrderMstService.getDataRowCountByConditions(conditions, this.getUserInfo()) > 0) {
			this.addFieldError("orderId", this.getText("orderId") + this.getText("eP.0004"));
			isValid = false;
		}
		return isValid;
	}
	
	/**
	 * 檢核是否有值
	 * 
	 * @return
	 * @throws Exception
	 */
	private boolean checkValidateRule() throws Exception {
		boolean isValid = true;
		try {
			setUpInfo();
			
			String custId =  labOrderMst.getLabCustMst().getCustId();
			
			// 取得並檢核客戶料是否存在
			labOrderMst.setLabCustMst(this.getLabCustMstService().get(custId, this.getUserInfo()));
			
			if (labOrderMst.getLabCustMst() == null) {
				this.addFieldError("custId", this.getText("custId") + this.getText("eP.0003"));
				isValid = false;
			}
		}
		catch (DdscApplicationException e) {
			// 取得 SQL 錯誤碼，並依多國語系設定顯示於Message box
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		catch (Exception ex) {
			DdscApplicationException e = new DdscApplicationException(ex, this.getUserInfo());
			this.addActionError(this.getText("eP.0022", new String[] {e.getMsgCode(), this.getText(e.getMsgCode()), e.getMsgFullMessage()}));
		}
		return isValid;
	}
	
	@Deprecated
	@Override
	public String copy() throws Exception {
		return null;
	}
	
	@Deprecated
	@Override
	public String copySubmit() throws Exception {
		return null;
	}
	
	@Deprecated
	@Override
	public String copyConfirm() throws Exception {
		return null;
	}
	
	@Deprecated
	@Override
	public String approve() throws Exception {
		return null;
	}
	
	

	public ILabOrderMstService getLabOrderMstService() {
		return labOrderMstService;
	}

	public void setLabOrderMstService(ILabOrderMstService labOrderMstService) {
		this.labOrderMstService = labOrderMstService;
	}

	public List<LabOrderMst> getLabOrderMstList() {
		return labOrderMstList;
	}

	public void setLabOrderMstList(List<LabOrderMst> labOrderMstList) {
		this.labOrderMstList = labOrderMstList;
	}

	public LabOrderMst getLabOrderMst() {
		return labOrderMst;
	}

	public void setLabOrderMst(LabOrderMst labOrderMst) {
		this.labOrderMst = labOrderMst;
	}

	public List<String> getOrderStatusList() {
		return orderStatusList;
	}

	public void setOrderStatusList(List<String> orderStatusList) {
		this.orderStatusList = orderStatusList;
	}

	public ILabCustMstService getLabCustMstService() {
		return labCustMstService;
	}

	public void setLabCustMstService(ILabCustMstService labCustMstService) {
		this.labCustMstService = labCustMstService;
	}
}
