% Ethan Robison
% Kevin Ye
% Daniel Thirman
% Alexander Martin

%
%	relationships
%

roles_relation(father/son).
	% son cannot be father of father
contradiction(relationship(X, father, Y), relationship(Y, father, X)).

symmetric(brothers).
contradiction(relationship(X, brothers, Y), relationship(X, father, Y)).
contradiction(relationship(X, brothers, Y), relationship(X, cousins, Y)).

symmetric(cousins).
	% son cannot be cousin of father
contradiction(roles_relation(X, father ,Y), roles_relation(X, cousin, Y)).

symmetric(family).
transitive(family).

symmetric(friends).
symmetric(at_odds).
symmetric(old_schoolmates).
symmetric(old_school_enemies).
symmetric(amicable_neighbors).
symmetric(belligerent_neighbors).
symmetric(cohorts).

generalizes(cousins, family).
generalizes(brothers, family).
generalizes(father, family).
generalizes(son, family).


generalizes(old_schoolmates, friends).
generalizes(amicable_neighbors, friends).
generalizes(old_school_enemies, at_odds).
generalizes(belligerent_neighbors, at_odds).

	% no need to make so many conflicting roles...
contradiction(relationship(X, friends, Y), relationship(X, at_odds, Y)).



symmetric(sexual_partners).
	% incest is out
contradiction(relationship(X, sexual_partners, Y), relationship(X, family, Y)).


roles_relation(pastor_of(X)/churchgoer_of(X)):-
	religion(X).
implies(role(C, pastor_of(_)), has(C, dogearred_NIV)).
implies(role(C, pastor_of(_)), has(C, jesus_figurine)).
	% one pastor_of(_) per town
contradiction(role(C, pastor_of(_)), role(D, pastor_of(_))) :-
	C \= D.

roles_relation(sheriff/criminal).
implies(role(C, sheriff), has(C, stetson_hat)).
implies(role(C, sheriff), has(C, handgun_45_caliber)).
% one sheriff per town
contradiction(role(C, sheriff), role(D, sheriff)):- 
	C \= D.

roles_relation(drug_dealer/druggee).
implies(role(C, drug_dealer), role(C, criminal)).
implies(role(C, druggee), role(C, criminal)).
implies(relationship(X, drug_dealer, Y), relationship(X, cohorts, Y)).

roles_relation(bartender/bar_patron).
roles_relation(gas_station_clerk/gas_station_patron).
roles_relation(car_salesman/dealership_patron).
roles_relation(mechanic/bodyshop_patron).

roles_relation(scientist/subject).
implies(role(C, scientist), has(C, walkie_talkie)).
implies(role(C, scientist), has(C, secret_facility_id_card)).

roles_relation(secret_agent/person_of_interest).
implies(role(C, secret_agent), has(C, handgun_45_caliber)).
implies(role(C, secret_agent), has(C, walkie_talkie)).
implies(role(C, secret_agent), has(C, secret_facility_id_card)).
implies(role(C, secret_agent), has(C, unmarked_sedan)).


conflicting_roles(scientist, secret_agent).
conflicting_roles(scientist, subject).
conflicting_roles(scientist, person_of_interest).
conflicting_roles(scientist, bartender).
conflicting_roles(scientist, car_salesman).
conflicting_roles(scientist, gas_station_clerk).
conflicting_roles(scientist, mechanic).
conflicting_roles(scientist, pastor_of(_)).
conflicting_roles(scientist, sheriff).
conflicting_roles(sheriff, criminal).
conflicting_roles(sheriff, bartender).
conflicting_roles(sheriff, car_salesman).
conflicting_roles(sheriff, gas_station_clerk).
conflicting_roles(sheriff, mechanic).
conflicting_roles(sheriff, pastor_of(_)).
conflicting_roles(pastor_of(_), churchgoer_of(_)).
conflicting_roles(pastor_of(_), bar_patron).
conflicting_roles(pastor_of(_), criminal).
conflicting_roles(pastor_of(_), bartender).
conflicting_roles(pastor_of(_), car_salesman).
conflicting_roles(pastor_of(_), gas_station_clerk).
conflicting_roles(pastor_of(_), mechanic).
conflicting_roles(bartender, bar_patron).
conflicting_roles(bartender, car_salesman).
conflicting_roles(bartender, gas_station_clerk).
conflicting_roles(bartender, mechanic).
conflicting_roles(gas_station_clerk, car_salesman).
conflicting_roles(gas_station_clerk, gas_station_patron).
conflicting_roles(gas_station_patron, mechanic).
conflicting_roles(car_salesman, dealership_patron).
conflicting_roles(car_salesman, mechanic).
conflicting_roles(mechanic, bodyshop_patron).


%
%	locations
%

location(gas_station).
location(brew_thru).
location(strip_club).
location(bar).
location(winn_dixie).
location(church).
location(school).
location(house).


location(inside_car(X)):-
	car(X).
	% anyone who starts out in the boat needs to be on the river
implies(at(X, inside_car(leaky_rowboat)), at(X, river)).

location(car_dealership).


location(bog).
location(tree_grove).
location(farm).
location(country_road).
location(cemetary).
location(river).


location(inside_spaceship).
location(mysterious_facility).
location(inside_abondoned_facility).
location(inside_active_facility).

implies(at(C, inside_active_facility), role(C, secret_agent)).
implies(at(C, inside_abondoned_facility), role(C, secret_agent)).

%
%	objects
%

object(X) :-
	car(X).
car(red_volvo).
car(stolen_hot_rod).
car(leaky_rowboat).	% laughs, this was deliberate
car(old_pickup).
car(new_pickup).
car(unmarked_sedan).


object(metal_detector).
object(electric_generator).
object(barrel_of_motor_oil).
object(suitcase_of_gold_bullion).


object(dogearred_NIV).
object(jesus_figurine).


object(tattered_confederate_flag).
object(collectors_shotgun).


object(handgun_45_caliber).
object(stetson_hat).


object(alien_corpse).
object(human_corpse).
contradiction(has(C, alien_corpse), has(D, alien_corpse)) :-
	C \= D.
contradiction(has(C, human_corpse), has(D, human_corpse)) :-
	C \= D.


object(walkie_talkie).
object(secret_facility_id_card).
object(vial_of_experimental_phlebotinum).

	% these sorts of things are a bit shady...
object(backpack_full_of_dynamite).
object(bloody_revolver).
implies(has(C, backpack_full_of_dynamite, role(C, criminal))).
implies(has(C, bloody_revolver), role(C, criminal)).


object(tesla_coil).
	% tesla coils are not a common possession...
implies(has(C, tesla_coil), role(C, scientist)).

object(truth_serum).
	% truth serum is for secret agents only
implies(has(C, truth_serum), role(C, secret_agent)).


%
%	needs
%

need(peer_approval).
need(make_parents_proud).
need(ten_grand_by_tomorrow).
need(get_out_of_this_town).

need(find_a_job).
	% why would such a person even need a job?
contradiction(needs(C, find_a_job), has(C, suitcase_of_gold_bullion)).

need(satisfy_curiosity).
need(build_a_flying_machine).

need(sexual_satisfaction).
	% sexual_satisfaction means that one <i>probably</i> is not getting any
contradiction(needs(C, sexual_satisfaction), relationship(C, sexual_partners, _)).

need(clean_up_this_town).
implies(needs(C, clean_up_this_town), role(C, sheriff)).

need(confirm_research_hypothesis).
	% have to have a hypothesis to confirm it
implies(needs(C, confirm_research_hypothesis), role(C, scientist)).

need(hide_facility).
need(guard_facility_secret).
	% have to know about the faacility to hide/guard it
implies(needs(C, hide_facility), access_to_secrets(C)).
implies(needs(C, guard_facility_secret), access_to_secrets(C)).


need(keep_parole).
	% have to have committed a crime to have parole
implies(needs(C, keep_parole), role(C, criminal)).

need(pay_bar_tab).
	% have to have a tab to need to pay it
implies(needs(C, pay_bar_tab), role(C, bar_patron)).
need(drink_to_forget).
	% bars are a good start...
implies(needs(C, drink_to_forget), role(C, bar_patron)).


religion(accepting_sort_of_christianity).
religion(bigoted_sort_of_christianity).
religion(eldritch).
religion(paganism).

sacrificing_sort_of_religion(eldritch).
sacrificing_sort_of_religion(paganism).

need(evangelize_religion(X)) :-
	religion(X).
need(follow_religion(X)) :-
	religion(X).

	% to evangelize a religion one must follow that religion
implies(needs(C, evangelize_religion(X)), follows_religion(C, X)).

need(encounter_human_for_sacrificial_religion(X)) :-
	sacrificing_sort_of_religion(X).

	% to need to find a human sacrifice, one must follow that sort of religion
implies(needs(C, encounter_human_for_sacrificial_religion(X)), follows_religion(C, X)).

	% sons follow their religions of their fathers
implies((relationship(X, son, Y), follows_religion(Y, R)), follows_religion(X, R)).
	% people who are trying to sacrifice a person are, knowingly or unknowingly, cohorts
implies((needs(C, encounter_human_for_sacrificial_religion(R)), needs(D, encounter_human_for_sacrificial_religion(R))), relationship(C, cohorts, D)).

contradiction(follows_religion(C, R1), follows_religion(C, R2)) :-
	R1 \= R2.

need(drug_addiction(X)) :-
	drug(X).

need(hide_drug_addiction_to(X)) :-
	drug(X).

implies(needs(C, hide_drug_addiction_to(X)), needs(C, drug_addiction(X))).
implies(needs(C, drug_addiction(_)), role(C, druggee)).

drug(meth).
drug(crack).
drug(bath_salts).
drug(human_blood).
drug(phlebotinum).

need(buy_new_tires_for_car(X)):-
	car(X).
	% have to have a car to need tires for it
implies(needs(C, buy_new_tires_for_car(X)), has(C, X)).
