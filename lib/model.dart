class CnicModel {
  String cnicNumber = "";
  String cnicIssueDate = "";
  String cnicHolderName = "";
  String cnicExpiryDate = "";
  String cnicHolderDateOfBirth = "";
  String cnicFatherName = "";

  @override
  String toString() {
    var string = '';
    string += cnicNumber.isEmpty ? "" : 'CNIC Number = $cnicNumber\n';
    string +=
    cnicExpiryDate.isEmpty ? "" : 'CNIC Expiry Date = $cnicExpiryDate\n';
    string += cnicIssueDate.isEmpty ? "" : 'CNIC Issue Date = $cnicIssueDate\n';
    string +=
    cnicHolderName.isEmpty ? "" : 'CNIC Holder Name = $cnicHolderName\n';
    string += cnicHolderDateOfBirth.isEmpty
        ? ""
        : 'CNIC Holder DoB = $cnicHolderDateOfBirth\n';
    string += cnicFatherName.toString().isEmpty
        ? ""
        : 'CNIC Holder Father Name = $cnicFatherName\n';

    return string;
  }
}
