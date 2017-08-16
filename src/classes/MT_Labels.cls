/**
 * Label storeage for Media Trasperancy App.
 *
 * History
 * -------
 * Date        AUTHOR                      DETAIL
 * 17.11.2016  Duc Nguyen Tien             Initial architecture & development
 * 15.02.2017  Falco Aulitzky              Added 'actual' and 'delta' variable
 * 20.04.2017  Falco Aulitzky              Technical documentation
 */

global class MT_Labels {
  private static MT_Labels instance = null;
  private MT_Labels() {
  }

  public static MT_Labels getInstance() {
    if (instance == null)
      instance = new MT_Labels();
    return instance;
  }

  public String add { get {if (add == null) add = Label.MT_Add; return add;} set; }
  public String campaignProbability { get {if (campaignProbability == null) campaignProbability = Label.MT_CampaignProbability; return campaignProbability;} set; }
  public String distribution { get {if (distribution == null) distribution = Label.MT_Distribution; return distribution;} set; }
  public String flight { get {if (flight == null) flight = Label.MT_Flight; return flight;} set; }
  public String max { get {if (max == null) max = Label.MT_Max; return max;} set; }
  public String sponsoring { get {if (sponsoring == null) sponsoring = Label.MT_Sponsoring; return sponsoring;} set; }
  public String spots { get {if (spots == null) spots = Label.MT_Spots; return spots;} set; }
  public String total { get {if (total == null) total = Label.MT_Total; return total;} set; }
  public String volume { get {if (volume == null) volume = Label.MT_Volume; return volume;} set; }
  public String weighted { get {if (weighted == null) weighted = Label.MT_Weighted; return weighted;} set; }

  /* @TODO Convert to custom labels as soon as business and flight plan have been properly updated to use their context specific custom labels */
  public String monthly = 'Monat';
  public String roi = 'ROI';
  public String sales = 'Umsatz';
  public String seasonal = 'Saisonaler';
  public String yield = 'Yield';
  public String spotFractionUnit = 'Spontanteil Unit';
  public String fixed = 'Fix';
  public String variable = 'Variabel';
  public String equity = 'Equity';
  public String actual = 'Actual';
  public String delta = 'Delta';

  public String JANUARY { get {if (JANUARY == null) JANUARY = 'Januar'; return JANUARY;} set; }
  public String FEBRUARY { get {if (FEBRUARY == null) FEBRUARY = 'Februar'; return FEBRUARY;} set; }
  public String MARCH { get {if (MARCH == null) MARCH = 'März'; return MARCH;} set; }
  public String APRIL { get {if (APRIL == null) APRIL = 'April'; return APRIL;} set; }
  public String MAY { get {if (MAY == null) MAY = 'Mai'; return MAY;} set; }
  public String JUNE { get {if (JUNE == null) JUNE = 'Juni'; return JUNE;} set; }
  public String JULY { get {if (JULY == null) JULY = 'Juli'; return JULY;} set; }
  public String AUGUST { get {if (AUGUST == null) AUGUST = 'August'; return AUGUST;} set; }
  public String SEPTEMBER { get {if (SEPTEMBER == null) SEPTEMBER = 'September'; return SEPTEMBER;} set; }
  public String OCTOBER { get {if (OCTOBER == null) OCTOBER = 'Oktober'; return OCTOBER;} set; }
  public String NOVEMBER { get {if (NOVEMBER == null) NOVEMBER = 'November'; return NOVEMBER;} set; }
  public String DECEMBER { get {if (DECEMBER == null) DECEMBER = 'Dezember'; return DECEMBER;} set; }

  /* Makes sure that the getters are called and the variables are properly initiated*/
  public MT_Labels prepareForSerialization() {
    String cont;
    cont = add;
    cont = campaignProbability;
    cont = distribution;
    cont = flight;
    cont = max;
    cont = sponsoring;
    cont = spots;
    cont = total;
    cont = volume;
    cont = weighted;
    cont = JANUARY;
    cont = FEBRUARY;
    cont = MARCH;
    cont = APRIL;
    cont = MAY;
    cont = JUNE;
    cont = JULY;
    cont = AUGUST;
    cont = SEPTEMBER;
    cont = OCTOBER;
    cont = NOVEMBER;
    cont = DECEMBER;
    return this;
  }

  public String ERR_Sync_Opportunity_Lock = 'Field is sync with Media Campaign Approval';
  public String ERR_Sync_MediaCampaign_Lock = 'Field is sync with Opportunity and Opportunity Approval';
  public String ERR_Sync_MediaCampain_InApprovalLock = 'Field is not editable during approval';

  public String ERR_Sync_MultipleChildCampaignValidation = '@Object has more than one campaign (@name)';
  public String Error_DETAIL_JS_BUTTON = 'In process of submitting approval request';

  public String MSG_ApprovalModule_Success = 'Der Freigabeprozess wurde gestartet.';
  public String MSG_ApprovalModule_Failure = 'Es gab einen Fehler beim Start des Freigabeprozesses. (@error)';
  public String MSG_ApprovalModule_EntryFailure = 'Der Freigabeprozess konnte nicht gestartet werden. (Die Opportunity Freigabe entspricht nicht den Eingangskritieren eines Freigabeprozesses)';
  public String MSG_ApprovalModule_EntryFailure_MissingIMAAgent = 'Der Freigabeprozess konnte nicht gestartet werden, da auf der Kampagne kein verantwortlicher IMA- Agent eingetragen ist.';

  public String ERR_MediaCampaign_No_OppApp = 'Es wurde keine gültige Opportunity Freigabe ausgewählt.';
  public String ERR_MediaCampaign_No_OppAppRecordTypeId = 'Die gewählte Opportunity Freigabe hat keinen Datensatztypen.';
  public String ERR_MediaCampaign_No_OppAppRecordTypeIdAllowed = 'Die gewählte Opportunity Freigabe hat keinen gültigen Datensatztypen.';

  public class MT_LabelsException extends Exception {
  }
}