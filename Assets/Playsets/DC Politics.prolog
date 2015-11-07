%
% Example Fiasco playset: DC politics
%

%
% Relationships
%

conflicting_roles([politician, strategist, staffer, opposition_researcher, intern,
		   lobbyist, journalist, billionaire, foreign_dictator, televangelist, activist,
		   special_prosecutor, supreme_court_justice, lawyer,
		   drug_dealer, madam, hired_burgler, hacker, honey_trap, 'PR strategist',
		   militia_member ]).

roles_relation(politician/lobbyist).

symmetric(political_rivals).
implies(relationship(X, political_rivals, _),
	role(X, politician)).
implies(relationship(_, political_rivals, Y),
	role(Y, politician)).

roles_relation(politician/strategist).
right_unique(politician/strategist).

roles_relation(journalist/politician).

roles_relation(politician/billionaire).

roles_relation(politician/staffer).
left_unique(politician/staffer).

roles_relation(politician/foreign_dictator).

roles_relation(politician/general).

roles_relation(politician/honey_trap).

roles_relation(general/honey_trap).

roles_relation(televangelist/honey_trap).

roles_relation(foreign_dictator/'PR strategist').

roles_relation(militia_member/X) :-
   member(X, [politician, journalist, supreme_court_justice, activist]).

roles_relation(majority_party/minority_party).
subrole(majority_party, politician).
subrole(minority_party, politician).
conflicting_roles(majority_party, minority_party).

roles_relation(insider/insurgent).
subrole(insider, politician).
subrole(insurgent, politician).

roles_relation(special_prosecutor/person_of_interest).

roles_relation(supreme_court_justice/litigant).

roles_relation(lawyer/client).

roles_relation(drug_dealer/client).

roles_relation(madam/client).

roles_relation(opposition_researcher/target).

roles_relation(hired_burgler/target).

roles_relation(hacker/target).

symmetric(conspirators).

symmetric(extramarital_affair).

symmetric(bonesmen).

roles_relation(televangelist/church_member).

roles_relation(celebrity/politician).

roles_relation(activist/target).

roles_relation(politician/intern).

left_unique(married).
right_unique(married).

symmetric(staying_married_for_the_kids).
generalization(staying_married_for_the_kids, married).

roles_relation(dominant/spouse).
generalization(dominant/spouse, married).

roles_relation(complainer/spouse).
generalization(complainer/spouse, married).

roles_relation(stepford_spouses).
generalization(stepford_spouses, married).

symmetric(sibling_rivals).

roles_relation(politician/estranged_child).

symmetric(old_flames).
symmetric(high_school_sweethearts).



%
% Needs
%
need(hide_my_addiction_to(X)) :-
	drug(X).
drug(meth).
drug(crack).
drug(bath_salts).
drug(human_blood).

need(kleptomaniac).
need(streaking).
need(hide_the_body).

role_need(estranged_child, make_my_parent_suffer).
role_need(politician, retire_with_a_cushy_wall_street_job).
role_need(politician, become_the_first_tourettes_patient_to_be_elected_president).

role_need(journalist, get_the_big_scoop).

need(make_50_grand_before_tuesday).
contradiction(needs(C, make_50_grand_before_tuesday),
	      role(C, billionaire)).

%
% Locations
%

location(the_capitol_building).

location(a_corn_farm_in_iowa).

role_location(politician, a_fact_finding_tour_in_the_bahmamas).

location(the_oval_office).

location(a_dc_pickup_bar).

location(the_watergate_hotel).

location(the_david_letterman_set).

location(the_police_station).

location(the_hellfire_club).

location(the_national_prayer_breakfast).

location('NORAD').

location(a_private_jet).

location(the_national_convention).

location('Focus on the Family gift shop').

location(area_51).

location('The Elvis Presley Museum').

location(very_discreet_rehab).

location(the_debates).

location(the_creation_museum).

location(the_rainbow_warrior).

location(hunting_club).

location(masonic_lodge).

location(underground_parking_garage).

location('Langley').

location('The Situation Room').

location('The Vatican').


%
% Objects
%

object('Ronald Reagan\'s Ouija board').

object(an_experimental_truth_serum).

object(half_a_kilogram_of_heroin).

object(the_nuclear_football).

object(sex_tape).

object(a_suitcase_full_of_cash).

object(classified_dossier).

object(stolen_cell_phone).

object(lingerie).