
module UpdateDb
  def self.update_customer
#    xlsm = Roo::Spreadsheet.open('//10.1.1.100/Data/share/01_Opportunity/IPG-J_Opportunity_all.xlsm')
    xlsm = Roo::Spreadsheet.open('/Users/kawaharakeisuke/Desktop/IPG-J_Opportunity_all.xlsm')
    mysheet = xlsm.sheet('Customer')
    i = 0
    mysheet.column(1).each do |email|
      i += 1
      next if i < 3 || !email
      customer = Customer.where(email: email).first_or_create
      customer.update({
        family_name: mysheet.cell(i, 5),
        given_name:  mysheet.cell(i, 3),
        title:       mysheet.cell(i, 6),
        company:     mysheet.cell(i, 7),
        dept:        mysheet.cell(i, 8)
           })

    end
  end

  def self.update_license
#    xlsx = Roo::Spreadsheet.open('//10.1.1.100/Data/share/11_License/IPG_Automotive_KK_License.xlsx')
    xlsx = Roo::Spreadsheet.open('/Users/kawaharakeisuke/Desktop/IPG_Automotive_KK_License.xlsx')
    mysheet = xlsx.sheet('Customer')
    i = 0
    mysheet.column(3).each do |license_num|
      i += 1
      next if i < 3 || !license_num
      license = License.where(license_num: license_num).first_or_create
      status = 0
      status = 1 if mysheet.cell(i, 7).to_s == "valid"
      license.update(status: status)
      # puts mysheet.cell(i, 7)
    end

  end
end

UpdateDb.update_customer
UpdateDb.update_license
