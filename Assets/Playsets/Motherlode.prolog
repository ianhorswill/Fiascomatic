% Ethan Robison, Ian Horswill
% 2016

conflicting_roles([captain, first_mate, engineer, quartermaster, foreman, miner, saloon_keeper, doctor, pirate, crew, lawman, yandere_pleasure_droid]).

%% relationships
% strictly professional
roles_relation(captain/first_mate).
roles_relation(captain/engineer).
roles_relation(captain/quartermaster).
unique_role(captain).
unique_role(first_mate).
unique_role(quartermaster).
roles_relation(doctor/problem_patient).
roles_relation(lawman/fugitive).

roles_relation(foreman/miner).
unique_role(foreman).

% family
symmetric(estranged_siblings).
symmetric(creepy_siblings).
roles_relation(parent/adopted_child).
antisymmetric(parent/adopted_child).
symmetric(child/grandparent_who_raised_them).
symmetric(competing_for_the_inheritance).

% intimate
symmetric(fuck_buddies).
symmetric(cabin_mates_for_too_long).
contradiction(role(captain, X), relationship(X, cabin_mates, _)).
symmetric(share_a_guilty_secret).
symmetric('co-conspirators').

roles_relation(yandere_pleasure_droid/hapless_owner).
roles_relation(yandere_pleasure_droid/cowed_owner).

% other
roles_relation(racist/alien).
roles_relation(missionary/atheist).
antisymmetric(friendly_but_secretly_hates).

% sketchy
roles_relation(gambler/bookie).
roles_relation(saloon_keeper/best_customer).
roles_relation(dealer/junkie).
roles_relation(thief/helper).
roles_relation(pirate/crew).

%% needs
% to get even
need(to_pay_off_gambling_debt).
imples(needs(C, to_pay_off_gambling_debt), role(C, gambler)).
need(to_kill_the_captain).
contradiction(needs(C, to_kill_the_captain), role(C, captain)).

% to get respect
need('to earn your Dad\'s respect').
need(to_make_up_with_your_child).
implies(needs(C, to_make_up_with_your_child), role(C, parent)).

% to get fucked
need(to_get_laid_by_an_on_planet_whore).

% to get out
need(to_get_a_real_job).
contradiction(needs(C, to_get_a_real_job), role(C, captain)).
need(to_sneak_off_with_the_motherlode).
need(to_escape_the_intergalactic_authorities).
need(to_get_a_stake_to_buy_my_own(X)) :-
   member(X, [ship, saloon, brothel, church, surf_shop]).

% to get loaded (with dough)
need(to_make_it_big).
need(to_cash_in_your_share_of_the_motherlode).

% to get loaded (with substance) 
need(satisfy_my_addiction_to(X)):-
	drug(X).

drug(meth).
drug(stim_fluid).
drug(human_blood).
drug('alien children\'s tears').
drug(risky_behavior).

need(pyromania).
need(pica).

need('To act like I\'m not from Phobos.').
need(agoraphobia).
need(barophobia).

need(to_convert_my_friends).

need(cosplayer).

need(to_save_the_asteroid_belt_from(X)) :-
   member(X, [commies, aliens, jews, bankers, pirates]).

%% locations
% all aboard
location(the_gally_tables).
location(the_captains_chair).
location(the_cabins).
location(the_capacious_but_empty_larders).
location(the_lifepod).
location(the_rec_room).
location(the_computer_core).

% down, down, to goblin town
location(the_entrance_to_the_mines).
location(mineshaft_38_R).
location('the ship\'s airlock').

% the docks
location(the_cyber_pub).
location('the quartermaster\'s station').
location(galactic_army_barracks).
location(on_planet_quarters).
location(the_church).

%% objects
% rock solid
object(a_bloodied_sonic_pick).
object(a_worn_out_space_suit).
object(a_radio_transponder_set_to_a_government_frequency).
object(a_hover_dolly_loaded_with_gems).
object(three_crates_of_explosives).
object(hand_scanner_with_motherlode_coordinates).

% badass
object(an_oversized_rock_drill).
object(a_new_spacecruiser).
object(tims_gatling_cannon).

% business as usual
object(a_breifcase_full_of_credits).
object(a_flask_of_stim_fluid).
object(a_key_to_the_hotel_room).
object(a_picture_of_the_incident).
object(a_recording_of_the_meeting).
object(the_stolen_keycard).
object(a_new_designer_drug).

% what the hell
object('Tim\'s left workboot').
object(someones_severed_hand).
object(a_literal_assload_of_diamonds).
object(larva_of_an_unknown_species).
object(that_rock_that_talks_to_me_in_my_sleep).
object(a_tribble).
object(an_alien_entheogen).
