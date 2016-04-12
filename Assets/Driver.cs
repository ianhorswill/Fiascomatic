using System;
using Prolog;
using UnityEngine;

// ReSharper disable once CheckNamespace
public class Driver : MonoBehaviour
{
    public GUIStyle CharacterNameStyle;

    public GUIStyle RelationshipStyle;

    public GUIStyle DetailStyle;

    private const int MaxPlayers = 6;

    private int playerCount = 3;

    private int countSelection;

    private readonly string[] playerCountStrings = { "3", "4", "5", "6" };

    private readonly string[] playerNames =
    {
        "Name1", "Name2", "Name3", "Name4", "Name5", "Name6"
    };

    private readonly string[] playerDetailStrings = { "detail", "detail", "detail", "detail", "detail", "detail" };
    private readonly object[] playerDetails = new object[MaxPlayers];
    private readonly bool[] playerDetailPin = new bool[MaxPlayers];
    private readonly string[] playerRelationshipStrings = { "relationship", "relationship", "relationship", "relationship", "relationship", "relationship" };
    private readonly object[] playerRelationships = new object[MaxPlayers];
    private readonly bool[] playerRelationshipPin = new bool[MaxPlayers];

    int currentPlaysetNumber;
    Playset currentPlayset;

    internal void Start()
    {
        SetPlayset(0);
    }

    void SetPlayset(int playsetNumber)
    {
        currentPlaysetNumber = playsetNumber;
        currentPlayset = Playset.Playsets[playsetNumber];
        Array.Clear(playerDetailPin, 0, playerDetailPin.Length);
        Array.Clear(playerRelationshipPin, 0, playerRelationshipPin.Length);
    }

    internal void OnGUI()
    {
        var nameHeight = CharacterNameStyle.lineHeight;

        GUI.Label(new Rect(30, 30, 0, 0), "Fiascomatic", CharacterNameStyle);

        GUI.Label(new Rect(30, 60, 100, 30), "Playset:");
        var playsetSelection = GUI.Toolbar(new Rect(0, 0, Screen.width, 20), currentPlaysetNumber, Playset.PlaysetNames);
        if (playsetSelection != currentPlaysetNumber)
        {
            SetPlayset(playsetSelection);
        }

        GUI.Label(new Rect(30, 90, 100, 30), "Players:");
        countSelection = GUI.Toolbar(new Rect(80, 90, 100, 20), countSelection, playerCountStrings);
        playerCount = countSelection + 3;

        GUI.Label(new Rect(30, 205, 150, 300), "Click on a character name to edit it");

        if (GUI.Button(new Rect(30, 130, 200, 60), "<b>Let the suffering begin!</b>"))
        {
            Setup();
        }

        if (GUI.Button(new Rect(30, 250, 100, 60), "<b>Quit</b>"))
        {
            Application.Quit();
        }

        for (int i = 0; i < playerCount; i++)
        {
            var textposition = PlayerScreenPosition(i);
            playerNames[i] = GUI.TextField(
                new Rect(textposition.x, textposition.y, 100, nameHeight),
                playerNames[i],
                CharacterNameStyle);
            var detailposition = DetailScreenPosition(i);
            GUI.Label(
                new Rect(detailposition.x, detailposition.y, 160, 300),
                playerDetailStrings[i],
                DetailStyle);
            if (playerDetails[i] != null)
                playerDetailPin[i] = GUI.Toggle(new Rect(detailposition.x - 25, detailposition.y, 20, 20), playerDetailPin[i], "");
            var relationshipposition = RelationshipScreenPosition(i);
            GUI.Label(
                new Rect(relationshipposition.x, relationshipposition.y, 160, 300),
                playerRelationshipStrings[i], 
                RelationshipStyle);
            if (playerRelationships[i] != null)
                playerRelationshipPin[i] = GUI.Toggle(new Rect(relationshipposition.x - 25, relationshipposition.y, 20, 20), playerRelationshipPin[i], "");
        }
    }

    private void Setup()
    {
        PrologContext.DefaultStepLimit = 1000000;
        switch (playerCount)
        {
            case 3:
                SolveSetup(new[]
                                {
                                    RelationshipTuple(0, 1), RelationshipTuple(1, 2), RelationshipTuple(2, 0),
                                    DetailTuple(0), DetailTuple(1), DetailTuple(2) 
                                });
                break;

            case 4:
                SolveSetup(new[]
                                {
                                    RelationshipTuple(0, 1), RelationshipTuple(1, 2), RelationshipTuple(2, 3),
                                    RelationshipTuple(3, 0),
                                    DetailTuple(0), DetailTuple(1), DetailTuple(2),
                                    DetailTuple(3) 
                                });
                break;

            case 5:
                SolveSetup(new[]
                                {
                                    RelationshipTuple(0, 1), RelationshipTuple(1, 2), RelationshipTuple(2, 3),
                                    RelationshipTuple(3, 4), RelationshipTuple(4, 0),
                                    DetailTuple(0), DetailTuple(1), DetailTuple(2),
                                    DetailTuple(3), DetailTuple(4)
                                });
                break;

            case 6:
                SolveSetup(new[]
                                {
                                    RelationshipTuple(0, 1), RelationshipTuple(1, 2), RelationshipTuple(2, 3),
                                    RelationshipTuple(3, 4), RelationshipTuple(4, 5), RelationshipTuple(5, 0), 
                                    DetailTuple(0), DetailTuple(1), DetailTuple(2),
                                    DetailTuple(3), DetailTuple(4), DetailTuple(5)
                                });
                break;
        }
    }

    private void SolveSetup(object[] setup)
    {
        using (var prologContext = PrologContext.Allocate(currentPlayset.KnowledgeBase, null))
        {
            if (!prologContext.IsTrue("make_setup", Prolog.Prolog.IListToPrologList(setup)))
                Debug.Log("Failed to make setup!");
            else
            {
                for (int i = 0; i < playerCount; i++)
                {
                    playerRelationships[i] = Term.CopyInstantiation(setup[i]);
                    playerRelationshipStrings[i] = 
                        string.Format("<b>{0}</b>",
                        ((Structure)(setup[i])).Argument(1).ToString().Replace("/", " / ")).Replace("_", " ");
                }
                for (int i = 0; i < playerCount; i++)
                {
                    playerDetails[i] = Term.CopyInstantiation(setup[playerCount + i]);
                    playerDetailStrings[i] = string.Format(
                        "{0}:\n<b>{1}</b>",
                        ((Structure)(setup[playerCount + i])).Argument(1),
                        ((Structure)(setup[playerCount + i])).Argument(2)).Replace("_", " ");
                }
            }
        }
    }

    object RelationshipTuple(int playerA, int playerB)
    {
        if (playerRelationshipPin[playerA])
            return playerRelationships[playerA];
        return new Structure(
            "relationship",
            playerNames[playerA],
            new LogicVariable("Relationship"),
            playerNames[playerB]);
    }

    object DetailTuple(int player)
    {
        if (playerDetailPin[player])
            return playerDetails[player];
        return new Structure(
            "detail",
            playerNames[player],
            new LogicVariable("DetailType"),
            new LogicVariable("Detail"));
    }

    private Vector2 PlayerScreenPosition(int i)
    {
        var center = new Vector2(Screen.width / 2f , Screen.height / 2f - 50);
        var angle = i * Math.PI * 2 / playerCount;
        var radius = (Math.Min(Screen.width, Screen.height) * 0.5f) - 70;
        var textposition = center + radius * new Vector2((float)Math.Cos(angle), (float)Math.Sin(angle));
        return textposition;
    }

    private Vector2 RelationshipScreenPosition(int i)
    {
        var center = new Vector2(Screen.width / 2f , Screen.height / 2f - 50);
        var angle = (i+0.5f) * Math.PI * 2 / playerCount;
        var radius = (Math.Min(Screen.width, Screen.height) * 0.5f) - 70;
        var textposition = center + radius * new Vector2((float)Math.Cos(angle), (float)Math.Sin(angle));
        return textposition;
    }

    private Vector2 DetailScreenPosition(int i)
    {
        return PlayerScreenPosition(i) + new Vector2(0f, CharacterNameStyle.lineHeight);
    }
}
