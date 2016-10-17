%% Prepare event

% Create and prepare
header = { 'event_name' , 'onset(s)' , 'duration(s)' 'content'};
EP     = EventPlanning(header);

% NextOnset = PreviousOnset + PreviousDuration
NextOnset = @(EP) EP.Data{end,2} + EP.Data{end,3};


%% Define a planning <--- paradigme

coeff = 2;

% --- Start ---------------------------------------------------------------

EP.AddPlanning({ 'StartTime' 0  0 [] });

% --- Stim ----------------------------------------------------------------

str = 'Attention ! \n les instructions vont \n défiler automatiquement \n et rapidement. \n Restez attentif...';
dur = 4*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

str = 'Durant les cinq prochaines minutes, \n vous aurez à effectuer, de façon alternée, \n une succession de 4 tâches differentes';
dur = 7.5*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

str = '1-écoute ou lecture de phrases : \n vous aurez juste à les écouter/lire \n attentivement (lecture silencieuse \n sans RIEN prononcer)';
dur = 9*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

str = '2-écoute ou lecture de soustractions : \n vous devrez les résoudre mentalement \n -ne PAS donner de réponse orale  \n -faire les calculs jusqu''au bout';
dur = 8*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

str = '3-''appuyez 3 fois sur le bouton \n gauche / droit'': \n pressez alors 3 fois sur le bon bouton \n aussi vite que possible(!!) suivant \n les instructions auditives/visuelles \n (laisser l''autre main au repos)';
dur = 8*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

str = '4-visualisation passive \n de damiers noir et blanc \n  \n (garder le regard au centre des damiers!)';
dur = 7*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

str = '5-ecoute passive d''une voix \n parlant une langue inconnue';
dur = 4*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 2 []});

% .........................................................................

str = 'Les stimulations visuelles consisteront \n en une serie de groupes de mots \n (phrase, instruction ou calcul) \n présentés rapidement';
dur = 7*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

str = 'en voici deux exemples';
dur = 2*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 1 []});

% .........................................................................

words = {'un incident';'s''est produit';'à l''entrée';'de l''usine'};
for w = 1 : length(words)
    str = words{w};
    dur = 0.250;
    EP.AddPlanning({ 'TextLoop' NextOnset(EP) dur str});
    EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.100 []});
end

% .........................................................................

EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 4 []});

% .........................................................................

words = {'calculez';'neuf';'moins';'trois'};
for w = 1 : length(words)
    str = words{w};
    dur = 0.250;
    EP.AddPlanning({ 'TextLoop' NextOnset(EP) dur str});
    EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 0.100 []});
end

% .........................................................................

EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 3 []});

% .........................................................................

str = 'Durant chaque essai, evitez \n de bouger les yeux. Une croix \n vous aidera à garder votre regard \n au centre de l''ecran';
dur = 7*coeff;
EP.AddPlanning({ 'SlideFixation' NextOnset(EP) dur str});

% .........................................................................

EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 2 []});

% .........................................................................

str = 'Les stimulations auditives (phrase, \n instruction ou calcul) ressembleront \n aux deux exemples suivant';
dur = 6*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 1 []});

% .........................................................................

wavdata = wavread([DataStruct.Parameters.Path.wav 'exemple.wav']);
dur = 4*coeff;
EP.AddPlanning({ 'Audio' NextOnset(EP) dur wavdata'});

% .........................................................................

wavdata = wavread([DataStruct.Parameters.Path.wav 'calc25.wav']);
dur = 4*coeff;
EP.AddPlanning({ 'Audio' NextOnset(EP) dur wavdata'});

% % .........................................................................
% 
% str = 'il y aura aussi des \n série de sons de \n differentes frequences \n juste les ecouter...';
% dur = 4*coeff;
% EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});
% 
% % .........................................................................
% 
% wavdata = wavread([DataStruct.Parameters.Path.wav 'exemple_sine.wav']);
% dur = 4*coeff;
% EP.AddPlanning({ 'Audio' NextOnset(EP) dur wavdata'});

% .........................................................................

str = 'ATTENTION ! \n ces essais vont se succeder assez \n rapidement. Restez donc attentif \n tout au long de ces cinq minutes';
dur = 6*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});

% .........................................................................

EP.AddPlanning({ 'BlackScreen' NextOnset(EP) 2 []});

% .........................................................................

str = 'Nous allons bientôt commencer';
dur = 4*coeff;
EP.AddPlanning({ 'Slide' NextOnset(EP) dur str});


% --- Stop ----------------------------------------------------------------

EP.AddPlanning({ 'StopTime' NextOnset(EP) 0 []});


%% Acceleration

if nargout > 0
    
    switch DataStruct.OperationMode
        
        case 'Acquisition'
            
            Speed = 1;
            
        case 'FastDebug'
            
            Speed = 10;
            
            new_onsets = cellfun( @(x) {x/Speed} , EP.Data(:,2) );
            EP.Data(:,2) = new_onsets;
            
            new_durations = cellfun( @(x) {x/Speed} , EP.Data(:,3) );
            EP.Data(:,3) = new_durations;
            
        case 'RealisticDebug'
            
            Speed = 1;
            
        otherwise
            error( 'DataStruct.OperationMode = %s' , DataStruct.OperationMode )
            
    end
    
end


%% Display

% To prepare the planning and visualize it, we can execute the function
% without output argument

if nargout < 1
    
    fprintf( '\n' )
    fprintf(' \n Total stim duration : %g seconds \n' , NextOnset(EP) )
    fprintf( '\n' )
    
    EP.Plot
    
end
