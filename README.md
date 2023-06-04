# AnthroTraits
A mod for Project Zomboid that adds anthro-themed traits for player characters, and integrates with mods that provide furry player models.
<h1>A message from the creator</h1>
Do you really enjoy this mod, or even better want to build off of it? Please consider <a href="https://ko-fi.com/badonnthedeer">donating to me</a> so I can pay my bills. I'm recently unemployed and every little bit helps!
<h1>Positive Trait List</h1>
<ul>
    <li><h2>Hoofed</h2><br>
    You have foot-hooves, which make you move faster, and your feet cannot be scratched, lacerated, or bitten.
    </li>
    <li><h2>Pawed</h2><br>
    You have foot-paws, which make you move stealthier.
    </li>
    <li><h2>Feral Body</h2><br>
    Like a feral, you are stronger but less fit.
    </li>
    <li><h2>Anthro Immunity</h2><br>
    Knox Infection is very rare, even from bites.
    </li>
    <li><h2>Herbivore</h2><br>
    After eating food classified as plant-based, gain an extra percentage of the stats the food affected<br>
    Note: This also lowers unhappiness gain or other negative effects by the same amount.<br>
    </li>
    <li><h2>Carnivore</h2><br>
    After eating food classified as meat, gain an extra percentage of the stats the food affected<br>
    Note: This also lowers unhappiness gain or other negative effects by the same amount.<br>
    </li>
    <li><h2>Carrion Eater</h2><br>
    Rotten meat's stats are more powerful, and don't make you sick.
    </li>
    <li><h2>Food Motivated</h2><br>
    Food makes you slightly less unhappy and bored;<br>
    Dog food doesn't make you unhappy.
    </li>
    <li><h2>Instinctual Carpenter</h2><br>
    Carpentry +1
    </li>
    <li><h2>Natural Tumbler</h2><br>
    The damage and severity of your falls are reduced.
    </li>
    <li><h2>Vestigial Wings</h2><br>
    You have enough of your ancestor's wings to not take fall damage.
    </li>
    <li><h2>Bug-o-ssieur</h2><br>
    You don't gain unhappiness when eating bugs.
    </li>
    <li><h2>Bull Rush</h2><br>
    When sprinting, knock zombies over at a cost of extra endurance.
    </li>
    <li><h2>Tailed</h2><br>
    Your tail allows you to run with more balance, reducing trip chance.
    </li>
    <li><h2>Slinky</h2><br>
    Traverse through entryways, over fences, and open and close containers more quickly.
    </li>
    <li><h2>Unwieldy Hands</h2><br>
    Actions requiring fine motor control are slower.
    </li>
    <li><h2>Keen Smell</h2>
    Detect corpses (walking or otherwise) by distance via a moodle.<br>
    Influenced by wind.
    </li>
    
</ul>
<h1>Negative Trait List</h1>
<ul>
    <li><h2>Feral Digestion</h2>
    Grape, onion, chocolate, gum, alcohol, and caffeine poison you.<br>
    (Not an exhaustive list for real life, be careful what you feed your pets!)
    </li>
    <li><h2>Warning Call</h2>
    When panicked, you have a good chance to vocalize your fear.
    </li>
    <li><h2>Stinky</h2>
    You stink. Zombies will be more attracted to you and other players may comment on your smell.
    </li>
</ul>
<h1>Sandbox Options</h1>
This mod uses sandbox options to give you the most configurable experience I can. It's advised to leave them on default settings.
<ul>
    <li><h2>General</h2>
        <ul>
        </ul>
    </li>
    <li><h2>Anthro Immunity</h2>
        <ul>
            <li><h3>AnthroImmunityScratchInfectionChance</h3>
                Chance to actually be infected after being infected from a scratch.<br>
                0-100, default 10% chance
            </li>
            <li><h3>AnthroImmunityLacerationInfectionChance</h3>
                Chance to actually be infected after being infected from a laceration.<br>
                0-100, default 15% chance
            </li>
            <li><h3>AnthroImmunityBiteInfectionChance</h3>
                Chance to actually be infected after a bite (normally 100%).<br>
                0-100, default 20% chance
            </li>
            <li><h3>AnthroImmunityBiteGetsRegularInfectionOnDefense</h3>
                If you're bitten but not infected with the Knox Infection, replace with wound infection.<br>
                True/False, default true
            </li>
        </ul>
    </li>
    <li><h2>Carnivore/Herbivore</h2>
        <ul>
            <li><h3>RightFoodBonus</h3>
                The percentage bonus that Carnivore/Herbivore gives you after eating.<br>
                0-1, default 0.5 bonus
            </li>
            <li><h3>WrongFoodMalus</h3>
                The percentage malus that Carnivore/Herbivore gives you after eating.<br>
                0-1, default -0.5 malus
            </li>
        </ul>
    </li>
    <li><h2>Carrion Eater</h2>
        <ul>
            <li><h3>CarrionEaterBonus</h3>
                The percentage bonus that Carrion Eater gives you after eating.<br>
                0-1, default 0.5 bonus
            </li>
        </ul>
    </li>
    <li><h2>Food Motivated</h2>
        <ul>
            <li><h3>FoodMotivatedBonus</h3>
                The flat happiness bonus that Food Motivated gives after eating.<br>
                0-100, default 5
            </li>
        </ul>
    </li>
    <li><h2>Feral Digestion</h2>
        <ul>
            <li><h3>FeralDigestionPoisonAmt</h3>
                The flat poison amount that Feral Digestion gives after eating the appropriate foods.<br>
                10-120, default 20 (Note: 120 poison is the strength of bleach)
            </li>
        </ul>
    </li>
    <li><h2>Exclaimer</h2>
        <ul>
            <li><h3>ExclaimerExclaimThresholdMultiplier</h3>
                The multiplier of the panic level that determines whether a character vocalizes with Exclaimer.<br>
                For example, 10 * 2 (level 2 panic, since level 1 panic is ignored) is 20. There is a 20% chance per minute to vocalize.
                1-33, default 10
            </li>
        </ul>
    </li>
    <li><h2>Stinky</h2>
        <ul>
            <li><h3>StinkyDistance</h3>
                The distance in tiles that a player with this trait attracts zombies.<br>
                1-100, default 3
            </li>
             <li><h3>StinkyLoudness</h3>
                Stinky makes a noise every minute to attract zombies. This determines how loud that noise is.<br>
                1-100, default 5
            </li>
            <li><h3>StinkyCommentChance</h3>
                The chance per minute that another (non-panicked, non-pained) player within StinkyDistance will comment on the smell. <br>
                0-1, default 0.001
            </li>
        </ul>
    </li>
    <li><h2>Bull Rush</h2>
        <ul>
            <li><h3>BullRushKnockdownEndCost</h3>
                The amount that knocking over a zombie with Bull Rush subtracts from your endurance.<br>
                0-1, default 0.1 (Endurance is a max of 1, so setting this to 1 will completely drain endurance.)
            </li>
        </ul>
    </li>
    <li><h2>Natural Tumbler</h2>
        <ul>
            <li><h3>NaturalTumblerFallTimeMult</h3>
                That amount that the fall time attribute is multiplied per frame, determining damage or death.<br>
                0-1, default 0.5 (This effectively doubles the height you can fall without injury or dying.)
            </li>
        </ul>
    </li>
    <li><h2>Tailed</h2>
        <ul>
            <li><h3>TailTripReduction</h3>
                If a character with Tailed trips, the chance to avoid tripping altogether.<br>
                0-100, default 33
            </li>
        </ul>
    </li>
    <li><h2>Unwieldy Hands</h2>
        <ul>
            <li><h3>UnwieldyHandsTimeIncrease</h3>
                The percentage increase of time it takes to do an action affected by Unwieldy Hands.<br>
                0-1, default 0.2
            </li>
        </ul>
    </li>
</ul>