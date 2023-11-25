## Modeling APL-Mediated Local Inhibition in the Fruit Fly Mushroom Body for Understanding Excitatory-Inhibitory Balance

Yijie Pan, Sachin Salim, Zhengxu Tang

Mushroom body is the learning center for most arthropods (including insects, shrimps, crabs etc.), and shares the same network structure with other learning hubs in mammals like cerebellum and hippocampus [1]. In those learning hubs, a relatively large population of neurons randomly receive combinatory inputs from different sensory channels so that the activities of ensembles of neurons represent a particular sensory context [2]. Sensory representations can be associated with specific behaviors by tuning connection strength between representation neurons and their output neurons [3]. Hence the sparse, less overlapping sensory representations in the large neuron population is critical for pattern separation and accuracy of learning [1,4]. In the Drosophila melanogaster (fruit fly) mushroom body, there are ~2000 Kenyon Cells which receive inputs from a random 6 out of 54 olfactory channels [5]. A giant GABAergic interneuron called APL is known essential for olfactory discrimination learning [6]. APL receives inputs from all Kenyon cells, and provides inhibition back to all Kenyon cells based on existing connectome datasets (Figure 2) [7,8]. Recent electrophysiology study shows the lateral inhibition from APL is local and not propagate to all Kenyon Cells [9]. The transcriptomics study of APL suggests that a lack of voltage gated channels for generating action potential may result in a local spreading of inhibition to Kenyon cells [10]. It is unknown how this local inhibition contributes to the sensory representations sparsity. What’s more, as each Kenyon cell connects with multiple output neurons along its axon [11], inhibitions from APL may alter the propagation of Kenyon Cell odor responses, eventually distal output neurons may receive sparser input than proximal output neurons.

## To-Do:
### Model construction:
- [x] Odor stimulus input from PNs
- [x] PN-KC connectivity
    - [x] Full-random
    - [x] Local-random 
- [x] KC-APL inhibitory connection
    - [x] No inhibition
    - [x] Local inhibition
    - [ ] Global inhibition (For global inhibition, it might be tricky to match the gsyn with local inhibition scenario?)
- [x] LIF-2D KC model

### Simulation:
- [x] Finding A value that allows 20% KCs will be activated by an odor on average (no inhibition)
- [ ] Simulating KC responses to 110 odors with conditions below (it took ~30 min on my computer to iterate through 110 odors with no inhibition model):
    - [ ] Full-random PN-KC connectivity
    - codes and results are in ```./simulation_results```
      - [x] No inhibition *for no inhibititon, I set gsyn = 0*
      - [x] Local inhibition *for local inhibititon, I set gsyn = -5, tau = 50*
      - [ ] Global inhibition
    - [ ] Local-random connectivity
      - [x] No inhibition 
      - [x] Local inhibition
      - [ ] Global inhibition
- [x] How inhibition range (connection strength decays with distance) affect sparseness, responding fraction (Sachin is working on this)

### Analysis simulation results:
- [x] Odor responses sparseness 
- [ ] Separability between odors for a given set of KC activities (we may need to discuss about this. Potential method we can use: inter-odor responses correlation coefficients | activated KC overlapped ratio | construct some simple linear separator to simulate don’ stream neuron and compare classifying performance after learning one odor?)


### Presentation (How long the presentation is? Probably we can start adding contents onto slides from the Monday) 
- [ ] Biological background 
- [ ] Model contrution
- [ ] Simulation results and analysis
- [ ] Conclution
