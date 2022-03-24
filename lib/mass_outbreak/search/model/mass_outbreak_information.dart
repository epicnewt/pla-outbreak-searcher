
class MassOutbreakInformation {
  late final String seed;
  late final int spawns;
  late final int species;

  MassOutbreakInformation.empty() {
    seed = "";
    spawns = 10;
    species = -1;
  }

  MassOutbreakInformation(this.seed, this.spawns, this.species);
}