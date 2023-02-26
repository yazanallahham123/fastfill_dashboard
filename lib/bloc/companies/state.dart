import 'package:equatable/equatable.dart';

import '../../model/company/companies_with_pagination.dart';
import '../../model/company/company.dart';
import '../../model/company/company_branches_with_pagination.dart';
import '../../model/group/groups_with_pagination.dart';

abstract class CompanyState extends Equatable{

  const CompanyState();

  @override
  List<Object?> get props => [];
}

class InitCompanyState extends CompanyState{
  const InitCompanyState();
}

class LoadingCompanyState extends CompanyState{
  const LoadingCompanyState();
}

class ErrorCompanyState extends CompanyState{
  final String error;

  const ErrorCompanyState(this.error);

  @override
  List<Object?> get props => [this.error];
}

class GotCompanyByCodeState extends CompanyState {
  final Company company;

  const GotCompanyByCodeState(this.company);

  @override
  List<Object?> get props => [this.company];
}

class GotCompaniesByNameState extends CompanyState {
  final CompaniesWithPagination companiesWithPagination;

  const GotCompaniesByNameState(this.companiesWithPagination);

  @override
  List<Object?> get props => [this.companiesWithPagination];
}

class GotCompaniesState extends CompanyState {
  final CompaniesWithPagination companiesWithPagination;

  const GotCompaniesState(this.companiesWithPagination);

  @override
  List<Object?> get props => [this.companiesWithPagination];
}

class UpdatedCompanyState extends CompanyState {
  final String updateResult;

  const UpdatedCompanyState(this.updateResult);

  @override
  List<Object?> get props => [this.updateResult];
}

class AddedCompanyState extends CompanyState {
  final String addResult;

  const AddedCompanyState(this.addResult);

  @override
  List<Object?> get props => [this.addResult];
}

class DeletedCompanyState extends CompanyState {
  final String deleteResult;

  const DeletedCompanyState(this.deleteResult);

  @override
  List<Object?> get props => [this.deleteResult];
}

class GotAllCompanyBranchesState extends CompanyState {
  final CompanyBranchesWithPagination companyBranchesWithPagination;

  const GotAllCompanyBranchesState(this.companyBranchesWithPagination);

  @override
  List<Object?> get props => [this.companyBranchesWithPagination];
}

class GotCompanyBranchesState extends CompanyState {
  final CompanyBranchesWithPagination companyBranchesWithPagination;

  const GotCompanyBranchesState(this.companyBranchesWithPagination);

  @override
  List<Object?> get props => [this.companyBranchesWithPagination];
}

class UpdatedCompanyBranchState extends CompanyState {
  final String updateResult;

  const UpdatedCompanyBranchState(this.updateResult);

  @override
  List<Object?> get props => [this.updateResult];
}

class AddedCompanyBranchState extends CompanyState {
  final String addResult;

  const AddedCompanyBranchState(this.addResult);

  @override
  List<Object?> get props => [this.addResult];
}

class DeletedCompanyBranchState extends CompanyState {
  final String deleteResult;

  const DeletedCompanyBranchState(this.deleteResult);

  @override
  List<Object?> get props => [this.deleteResult];
}

class GotGroupsByNameState extends CompanyState {
  final GroupsWithPagination groupsWithPagination;

  const GotGroupsByNameState(this.groupsWithPagination);

  @override
  List<Object?> get props => [this.groupsWithPagination];
}


class GotGroupsState extends CompanyState {
  final GroupsWithPagination groupsWithPagination;

  const GotGroupsState(this.groupsWithPagination);

  @override
  List<Object?> get props => [this.groupsWithPagination];
}

class UpdatedGroupState extends CompanyState {
  final String updateResult;

  const UpdatedGroupState(this.updateResult);

  @override
  List<Object?> get props => [this.updateResult];
}

class AddedGroupState extends CompanyState {
  final String addResult;

  const AddedGroupState(this.addResult);

  @override
  List<Object?> get props => [this.addResult];
}

class DeletedGroupState extends CompanyState {
  final String deleteResult;

  const DeletedGroupState(this.deleteResult);

  @override
  List<Object?> get props => [this.deleteResult];
}
