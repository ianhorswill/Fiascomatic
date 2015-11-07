using System;
using System.IO;
using System.Collections.Generic;
using UnityEngine;
using Prolog;

public class Playset
{
    const string PlaysetsDirectory = "Playsets";

    public static readonly List<Playset> Playsets = new List<Playset>();
    public static readonly string[] PlaysetNames;
    static Playset()
    {
        string playsetsPath = Path.Combine(Application.dataPath, PlaysetsDirectory);
        string[] playsetsDirectory = Directory.GetFiles(playsetsPath);
        var names = new List<string>();
        foreach (var playset in playsetsDirectory)
        {
            if (Path.GetExtension(playset) == ".prolog")
            {
                var playsetName = Path.GetFileNameWithoutExtension(playset);
                if (playsetName != null)
                {
                    Playsets.Add(new Playset(playset));
                    names.Add(playsetName);
                }
            }
        }
        PlaysetNames = names.ToArray();
    }


    private Playset(string path)
    {
        KnowledgeBase = new KnowledgeBase(Path.GetFileNameWithoutExtension(path), null);
        KnowledgeBase.Consult(Path.Combine(Application.dataPath, "Solver.prolog"));
        KnowledgeBase.Consult(path);
    }

    public readonly KnowledgeBase KnowledgeBase;
}

