# AnthroTraits
A mod for Project Zomboid that adds realistic, balanced traits for anthropormorphic player characters, and integrates with mods that provide furry player models.
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
    <li><h2>Beast of Burden</h2>
    Your body's frame is well-built for carrying weight.<br>
    </li>
    <li><h2>Digitigrade</h2>
    Your legs aren't straight, giving your stomps increased power.<br>
    </li>
    <li><h2>Keen Smell (incoming)</h2>
    Detect corpses (walking or otherwise) by distance.<br>
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
    <li><h2>Lonely</h2>
    You need a pack. Time spent away from others makes you unhappy.
    </li>
    <li><h2>Torpor</h2>
    Still affected by the winter, you have less endurance during the cold months.
    </li>
</ul>
<h1>Sandbox Options</h1>
This mod uses sandbox options to give you the most configurable experience I can. It's advised to leave them on default settings.
<ul>
    <li><h2>General</h2>
        <ul>
            <li><h3>Traits Restrict Species Choice / TraitsRestrictSpeciesChoices</h3>
                NOT YET IMPLEMENTED.<br>
                type = boolean, default = true
            </li>
        </ul>
    </li>
    <li><h2>Anthro Immunity</h2>
        <ul>
            <li><h3>Anthro Immunity Scratch Chance / AnthroImmunityScratchInfectionChance</h3>
                Chance to actually be infected after being infected from a scratch.<br>
                0-100, default .10
            </li>
            <li><h3>Anthro Immunity Laceration Chance / AnthroImmunityLacerationInfectionChance</h3>
                Chance to actually be infected after being infected from a laceration.<br>
                0-100, default .15
            </li>
            <li><h3>Anthro Immunity Bite Chance / AnthroImmunityBiteInfectionChance</h3>
                Chance to actually be infected after a bite (normally 100%).<br>
                0-100, default .20
            </li>
            <li><h3>Anthro Immunity Bite Infection / AnthroImmunityBiteGetsRegularInfectionOnDefense</h3>
                If you're bitten but not infected with the Knox Infection, replace with wound infection.<br>
                True/False, default true
            </li>
        </ul>
    </li>
    <li><h2>Carnivore/Herbivore</h2>
        <ul>
            <li><h3>-ivore Food Bonus / RightFoodBonus</h3>
                The percentage bonus that Carnivore/Herbivore gives you after eating.<br>
                0-1, default 0.5 bonus
            </li>
            <li><h3>-ivore Food Malus / WrongFoodMalus</h3>
                The percentage malus that Carnivore/Herbivore gives you after eating.<br>
                0-1, default -0.5 malus
            </li>
        </ul>
    </li>
    <li><h2>Carrion Eater</h2>
        <ul>
            <li><h3>Carrion Food Stat Increase / CarrionEaterBonus</h3>
                The percentage bonus that Carrion Eater gives you after eating.<br>
                0-1, default 0.5 bonus
            </li>
        </ul>
    </li>
    <li><h2>Food Motivated</h2>
        <ul>
            <li><h3>Food Motivated Happiness Bonus / FoodMotivatedBonus</h3>
                The flat happiness bonus that Food Motivated gives after eating.<br>
                0-100, default 5
            </li>
        </ul>
    </li>
    <li><h2>Feral Digestion</h2>
        <ul>
            <li><h3>Feral Digestion Poison Amount / FeralDigestionPoisonAmt</h3>
                The flat poison amount that Feral Digestion gives after eating the appropriate foods.<br>
                10-120, default 20 (Note: 120 poison is the strength of bleach)
            </li>
        </ul>
    </li>
    <li><h2>Exclaimer</h2>
        <ul>
            <li><h3>Exclaimer Chance Multiplier / ExclaimerExclaimThresholdMultiplier</h3>
                The multiplier of the panic level that determines whether a character vocalizes with Exclaimer.<br>
                For example, 10 * 2 (level 2 panic, since level 1 panic is ignored) is 20. There is a 20% chance per minute to vocalize.
                1-33, default 10
            </li>
        </ul>
    </li>
    <li><h2>Stinky</h2>
        <ul>
            <li><h3>Stinky Distance Affected / StinkyDistance</h3>
                The distance in tiles that a player with this trait attracts zombies.<br>
                1-100, default 3
            </li>
             <li><h3>Stinky Attraction Strength / StinkyLoudness</h3>
                Stinky makes a noise every minute to attract zombies. This determines how loud that noise is.<br>
                1-100, default 5
            </li>
            <li><h3>Stinky Comment Chance / StinkyCommentChance</h3>
                The chance per minute that another (non-panicked, non-pained) player within StinkyDistance will comment on the smell. <br>
                0-1, default 0.001
            </li>
        </ul>
    </li>
    <li><h2>Bull Rush</h2>
        <ul>
            <li><h3>Bull Rush Endurance Cost / BullRushKnockdownEndCost</h3>
                The amount that knocking over a zombie with Bull Rush subtracts from your endurance.<br>
                0-1, default 0.1 (Endurance is a max of 1, so setting this to 1 will completely drain endurance.)
            </li>
        </ul>
    </li>
    <li><h2>Natural Tumbler</h2>
        <ul>
            <li><h3>Natural Tumbler Fall Reduction / NaturalTumblerFallTimeMult</h3>
                That amount that the fall time attribute is multiplied per frame, determining damage or death.<br>
                0-1, default 0.5 (This effectively doubles the height you can fall without injury or dying.)
            </li>
        </ul>
    </li>
    <li><h2>Tailed</h2>
        <ul>
            <li><h3>Tailed Trip Save Chance / TailTripReduction</h3>
                If a character with Tailed trips, the chance to avoid tripping altogether.<br>
                0-100, default 33
            </li>
        </ul>
    </li>
    <li><h2>Unwieldy Hands</h2>
        <ul>
            <li><h3>Unwieldy Hands Time Increase / UnwieldyHandsTimeIncrease</h3>
                The percentage increase of time it takes to do an action affected by Unwieldy Hands.<br>
                0-1, default 0.2
            </li>
        </ul>
    </li>
    <li><h2>Beast Of Burden</h2>
        <ul>
            <li><h3>Beast of Burden Increase / BeastOfBurdenPctIncrease</h3>
                Percentage increase of total max weight attribute with Beast of Burden.<br>
                0-1, default .15,
            </li>
        </ul>
    </li>
    <li><h2>Digitigrade</h2>
        <ul>
            <li><h3>Digitigrade Stomp Increase / DigitigradeStompPowerPctIncrease</h3>
                Percentage increase of total stomp power.<br>
                0-1, default .50,
            </li>
        </ul>
    </li>
    <li><h2>Lonely</h2>
        <ul>
            <li><h3>Lonely Hours Until Affected / LonelyHoursToAffect</h3>
                The hours elapsed until the Lonely trait adds unhappiness per hour.<br>
                2-100, default 6,
            </li>
            <li><h3>Lonely Hourly Unhappiness / LonelyHourlyUnhappyIncrease</h3>
                The amount of unhappiness added every hour until another player is seen again.<br>
                0-1, default .05,
            </li>
        </ul>
    </li>
    <li><h2>Torpor</h2>
        <ul>
            <li><h3>Torpor Endurance Decrease / TorporEnduranceDecrease</h3>
                The amount removed from maximum endurance during the winter.<br>Endurance is 0-1, so a value of .1 removes 10 total endurance during winter.<br>
                0-1, default .1,
            </li>
        </ul>
    </li>
</ul>