

import 'package:equatable/equatable.dart';

import '../../model/company/company.dart';
import '../../model/company/company_branch.dart';
import '../../model/group/group.dart';

abstract class CompanyEvent extends Equatable{

  const CompanyEvent();

  @override
  List<Object?> get props => [];
}

class CompanyInitEvent extends CompanyEvent {
  const CompanyInitEvent();
}

class GetCompanyByCode extends CompanyEvent {
  final String code;
  const GetCompanyByCode(this.code);

  @override
  List<Object?> get props => [this.code];
}

class GetCompaniesByName extends CompanyEvent {
  final String name;
  final int page;
  const GetCompaniesByName(this.name, this.page);

  @override
  List<Object?> get props => [this.name, this.page];
}

class GetCompaniesEvent extends CompanyEvent {
  final int page;
  const GetCompaniesEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}

class GetAllCompanyBranchesEvent extends CompanyEvent {
  const GetAllCompanyBranchesEvent();
}


class GetCompanyBranchesEvent extends CompanyEvent {
  final int companyId;
  const GetCompanyBranchesEvent(this.companyId);

  @override
  List<Object?> get props => [this.companyId];
}

class UpdateCompanyEvent extends CompanyEvent {
  final Company company;
  const UpdateCompanyEvent(this.company);

  @override
  List<Object?> get props => [this.company];
}

class UpdateCompanyBranchEvent extends CompanyEvent {
  final CompanyBranch companyBranch;
  const UpdateCompanyBranchEvent(this.companyBranch);

  @override
  List<Object?> get props => [this.companyBranch];
}

class AddCompanyEvent extends CompanyEvent {
  final Company company;
  const AddCompanyEvent(this.company);

  @override
  List<Object?> get props => [this.company];
}

class AddCompanyBranchEvent extends CompanyEvent {
  final CompanyBranch companyBranch;
  const AddCompanyBranchEvent(this.companyBranch);

  @override
  List<Object?> get props => [this.companyBranch];
}

class DeleteCompanyEvent extends CompanyEvent {
  final Company company;
  const DeleteCompanyEvent(this.company);

  @override
  List<Object?> get props => [this.company];
}

class DeleteCompanyBranchEvent extends CompanyEvent {
  final CompanyBranch companyBranch;
  const DeleteCompanyBranchEvent(this.companyBranch);

  @override
  List<Object?> get props => [this.companyBranch];
}


class GetGroupsByName extends CompanyEvent {
  final String name;
  final int page;
  const GetGroupsByName(this.name, this.page);

  @override
  List<Object?> get props => [this.name, this.page];
}

class GetGroupsEvent extends CompanyEvent {
  final int page;
  const GetGroupsEvent(this.page);

  @override
  List<Object?> get props => [this.page];
}

class DeleteGroupEvent extends CompanyEvent {
  final Group group;
  const DeleteGroupEvent(this.group);

  @override
  List<Object?> get props => [this.group];
}


class AddGroupEvent extends CompanyEvent {
  final Group group;
  const AddGroupEvent(this.group);

  @override
  List<Object?> get props => [this.group];
}

class UpdateGroupEvent extends CompanyEvent {
  final Group group;
  const UpdateGroupEvent(this.group);

  @override
  List<Object?> get props => [this.group];
}